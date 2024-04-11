import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vesam_shop/data/modeels/basket.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/theme.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تکمیل خرید'),
      ),
      body: BlocListener<BasketBloc, BasketState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            launchUrl(
              Uri.parse('https://flutter.vesam24.com${state.getaway}'),
              mode: LaunchMode.externalApplication,
            );
          }
        },
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fullNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'نام و نام خانوادگی را وارد کنید';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'نام و نام خانوادگی',
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        textAlign: TextAlign.left,
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' شماره تلفن را وارد کنید';
                          }
                          if (value.length < 11) {
                            return 'شماره تلفن 11 رقم میباشد';
                          }
                          if (!value.startsWith('09')) {
                            return 'شماره تلفن صحیح نمیباشد';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        keyboardType: TextInputType.phone,
                        decoration:
                            const InputDecoration(labelText: 'شماره همراه'),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        textAlign: TextAlign.left,
                        controller: postalCodeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'کد پستی را وارد کنید';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'کد پستی'),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'آدرس را وارد کنید';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        decoration: const InputDecoration(labelText: 'آدرس'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.all(24.0),
                width: MediaQuery.of(context).size.width,
                decoration:
                    const BoxDecoration(color: AppColors.kWhite, boxShadow: [
                  BoxShadow(
                    color: AppColors.kGray200,
                    blurRadius: 2.0,
                  )
                ]),
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<BasketBloc>(context).add(
                        PaymentProducts(
                          Payment(
                            receiverFullName: fullNameController.text,
                            receiverPhoneNumber: phoneController.text,
                            receiverPostalCode: postalCodeController.text,
                            receiverAddress: addressController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('تایید و پرداخت'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
