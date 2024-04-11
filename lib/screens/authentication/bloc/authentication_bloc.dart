import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/services/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import '../../../data/modeels/authentication.dart';
import '../../../data/services/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  final HomeService homeService;

  AuthenticationBloc(this.authenticationService, this.homeService)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      //  LOGIN
      if (event is LodingButtonClicked) {
        emit(LoginLoading());
        try {
          var response =
              await authenticationService.login(event.authentication);
          if (response.accessToken != null) {
            await prefs.setString('token', response.accessToken!);
            currentUser = await homeService.getUserInfo();
            isLogin.value = true;
          }
          emit(LodingSuccess(response.accessToken!));
        } catch (e) {
          emit(LoginError('خطای نامشخص'));
        }
        // REGISTER
        if (event is RegisterButtonClicked) {
          emit(RegisterLoading());
          try {
            await authenticationService.register(event.authentication);
            emit(RegisterSuccess());
          } catch (e) {
            emit(RegisterError('خطای نامشخص'));
          }
        }
      }
    });
  }
}
