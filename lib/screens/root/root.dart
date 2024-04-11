import 'package:flutter/material.dart';
import 'package:vesam_shop/screens/basket/basket.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/theme.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = 0;

  final GlobalKey<NavigatorState> homekey = GlobalKey();
  final GlobalKey<NavigatorState> basketkey = GlobalKey();
  final GlobalKey<NavigatorState> profilekey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedScreenIndex,
          onTap: (value) {
            setState(() {
              selectedScreenIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          backgroundColor: AppColors.kWhite,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'صفحه اصلی'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'اطلاعات کاربری'),
          ]),
      body: IndexedStack(
        index: selectedScreenIndex,
        children: [
          Navigator(
            key: homekey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const HomeScreen(),
              settings: settings,
            ),
          ),
          Navigator(
            key: basketkey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const BasketScreen(),
              settings: settings,
            ),
          ),
          Navigator(
            key: profilekey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
              settings: settings,
            ),
          ),
        ],
      ),
    );
  }
}
