import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vesam_shop/data/modeels/authentication.dart';
import 'package:vesam_shop/screens/authentication/bloc/authentication_bloc.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/snackbar.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int groupValue = 0;
  bool isNotVisblePassword = true;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emilController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 20.0),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              showCustomAlert(
                context,
                'ثبت نام شما با موفقیت انجام شد لطفا وارد شوید',
              );
            }
            if (state is LodingSuccess) {
              Navigator.pop(context);
              showCustomAlert(
                context,
                'با موفقیت وارد شدید',
              );
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: State is LoginLoading || state is RegisterLoading
                  ? null
                  : () {
                      if (formkey.currentState!.validate()) {
                        Authentication authentication = Authentication(
                          fullName: fullNameController.text,
                          phoneNumber: phoneController.text,
                          email: emilController.text,
                          password: passwordController.text,
                        );
                        // LOGIN
                        if (groupValue == 0) {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LodingButtonClicked(authentication));
                        }
                        // REGISTER
                        else {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(RegisterButtonClicked(authentication));
                        }
                      }
                    },
              child: State is LoginLoading || state is RegisterLoading
                  ? const CupertinoActivityIndicator()
                  : Text(
                      groupValue == 0
                          ? 'ورود به وسام شاپ'
                          : 'ثبت نام در وسام شاپ',
                    ),
            );
          },
        ),
      ),
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 60.0,
                  height: 60.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'به وسام شاپ خوش آمدید',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CupertinoSlidingSegmentedControl<int>(
                  groupValue: groupValue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  backgroundColor: AppColors.kGray50,
                  thumbColor: AppColors.kWhite,
                  children: {
                    0: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        'ورود',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: groupValue == 0
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: groupValue == 0
                              ? AppColors.kPrimary500
                              : AppColors.kGray700,
                        ),
                      ),
                    ),
                    1: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        'ثبت نام',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: groupValue == 1
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: groupValue == 1
                              ? AppColors.kPrimary500
                              : AppColors.kGray700,
                        ),
                      ),
                    ),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      groupValue = value!;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    groupValue == 0 ? 'ورود' : 'ثبت نام',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    groupValue == 0
                        ? 'جهت ورود به وسام شاپ، ایمیل و رمزعبور خود را وارد کنید.'
                        : 'جهت ثبت‌نام در وسام شاپ، موارد خواسته شده را تکمیل نمایید.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                groupValue == 1
                    ? Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'نام و نام خانوادگی  اجباری میباشد';
                              }
                              return null;
                            },
                            controller: fullNameController,
                            decoration: const InputDecoration(
                              labelText: 'نام و نام خانوادگی',
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'شماره موبایل اجباری میباشد';
                              }
                              if (value.length < 11) {
                                return 'شماره تلفن 11 رقم میباشد';
                              }
                              return null;
                            },
                            controller: phoneController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: 'شماره موبایل',
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                        ],
                      )
                    : const SizedBox(),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'ایمیل اجباری میباشد';
                    }
                    return null;
                  },
                  controller: emilController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'ایمیل',
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'رمز عبور اجباری میباشد';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: isNotVisblePassword,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'رمز عبور',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isNotVisblePassword = !isNotVisblePassword;
                        });
                      },
                      icon: Icon(
                        isNotVisblePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
