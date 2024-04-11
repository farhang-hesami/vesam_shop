import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/data/services/authentication.dart';
import 'package:vesam_shop/data/services/basket.dart';
import 'package:vesam_shop/data/services/home.dart';
import 'package:vesam_shop/data/services/product.dart';
import 'package:vesam_shop/data/services/profile.dart';
import 'package:vesam_shop/screens/authentication/bloc/authentication_bloc.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import 'package:vesam_shop/screens/profile/bloc/profile_bloc.dart';
import 'package:vesam_shop/screens/prouduct/bloc/product_bloc.dart';
import 'package:vesam_shop/screens/splash.dart';
import 'package:vesam_shop/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

late final SharedPreferences prefs;
ValueNotifier<bool> isLogin = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('favorite_product');

  prefs = await SharedPreferences.getInstance();
  isLogin.value = prefs.getString('token') != null;
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => HomeBloc(HomeService()),
    ),
    BlocProvider(
      create: (context) => ProductBloc(ProductService()),
    ),
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(AuthenticationService(), HomeService()),
    ),
    BlocProvider(
      create: (context) => ProfileBloc(ProfileService()),
    ),
    BlocProvider(
      create: (context) => BasketBloc(BasketService()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child as Widget,
        );
      },
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Vesam Shop',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'),
      ],
      locale: const Locale('fa', 'IR'),
      theme: lighehtTheme(),
      home: const SplashScreen(),
    );
  }
}
