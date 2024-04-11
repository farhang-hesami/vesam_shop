import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vesam_shop/screens/authentication/authentication.dart';
import 'package:vesam_shop/utils/navigator.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/guest.svg',
            width: 300,
            height: 300,
          ),
          Text(
            'لطفا به حساب کاربری خود وارد شوید !',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12.0),
          ElevatedButton(
              onPressed: () {
                goScreen(
                  context: context,
                  screen: const AuthenticationScreen(),
                );
              },
              child: const Text(
                'ورود به حساب کاربری',
              )),
        ],
      ),
    );
  }
}
