import 'package:flutter/material.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/guest.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import 'package:vesam_shop/screens/profile/favorite_product.dart';
import 'package:vesam_shop/screens/profile/user_comments.dart';
import 'package:vesam_shop/screens/profile/user_payment.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اطلاعات کاربری',
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: isLogin,
        builder: (context, value, child) {
          if (value) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: AppColors.kGray50,
                    foregroundColor: AppColors.kGray700,
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 40.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    currentUser!.fullName!,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    currentUser!.phoneNumber!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListTile(
                    leading: const Icon(Icons.message_outlined),
                    title: const Text('نظرات من'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      goScreen(
                          context: context, screen: const UserCommentsScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.favorite_border_outlined),
                    title: const Text('لیست مورد علاقه ها'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      goScreen(
                          context: context,
                          screen: const FavoriteProductScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.payment_outlined),
                    title: const Text('پرداخت های من'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      goScreen(
                        context: context,
                        screen: const UserPaymentsScreen(),
                      );
                    },
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () async {
                      await prefs.remove('token');
                      isLogin.value = false;
                      currentUser = null;
                    },
                    icon: const Icon(
                      Icons.exit_to_app_outlined,
                      color: AppColors.kAlert500,
                    ),
                    label: Text(
                      'خروج از حساب کاربری',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.kAlert500,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            );
          } else {
            return const GuestScreen();
          }
        },
      ),
    );
  }
}
