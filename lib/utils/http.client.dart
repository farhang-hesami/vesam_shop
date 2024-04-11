import 'package:dio/dio.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/authentication/authentication.dart';
import 'package:vesam_shop/utils/navigator.dart';

import 'package:vesam_shop/utils/snackbar.dart';

final Dio httpClient = Dio(
  BaseOptions(
    baseUrl: 'https://flutter.vesam24.com/api/',
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) async {
        switch (e.response?.statusCode) {
          case 400:
            // نمایش پیغام خطای 400
            showCustomAlert(
              navigatorKey.currentContext!,
              'خطای درخواست',
              AlertType.error,
            );
            break;
          case 401:
            showCustomAlert(
              navigatorKey.currentContext!,
              'خطای احراز هویت',
              AlertType.error,
            );
            break;
          case 403:
            // نمایش پیغام خطای 403
            showCustomAlert(
              navigatorKey.currentContext!,
              'خطای دسترسی',
              AlertType.error,
            );
            break;
          case 404:
            // نمایش پیغام خطای 404
            showCustomAlert(
              navigatorKey.currentContext!,
              'خطای یافت نشدن',
              AlertType.error,
            );
            break;
          case 500:
            // نمایش پیغام خطای 500
            showCustomAlert(
              navigatorKey.currentContext!,
              'خطای سرور',
              AlertType.error,
            );
            break;
          default:
            // نمایش پیغام خطای نامشخص
            showCustomAlert(
              navigatorKey.currentContext!,
              'خطای نامشخص',
              AlertType.error,
            );
        }
        if (e.response!.statusCode == 401) {
          await prefs.remove('token');
          isLogin.value = false;
          goScreen(
            context: navigatorKey.currentContext!,
            screen: const AuthenticationScreen(),
            fullScreen: true,
          );
        } else if (e.response!.data['errors'] != null) {
          var errors = e.response!.data['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            showCustomAlert(
              navigatorKey.currentContext!,
              errors.values.first[0].toString(),
              AlertType.error,
            );
          }
        } else {
          showCustomAlert(
            navigatorKey.currentContext!,
            'خطای نامشخص',
            AlertType.error,
          );
        }
        throw Exception();
      },
      onRequest: (options, handler) {
        String? userToken = prefs.getString('token');
        if (userToken != null) {
          options.headers['Authorization'] = 'Bearer $userToken';
        }
        handler.next(options);
      },
    ),
  );
