import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/data/modeels/user.dart';
import 'package:vesam_shop/data/services/home.dart';
import 'package:vesam_shop/main.dart';

part 'home_event.dart';
part 'home_state.dart';

User? currentUser;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeService homeService;

  HomeBloc(this.homeService) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeScreenStarted) {
        emit(HomeLoding());
        try {
          var response = await homeService.getGeneralInfo();
          if (isLogin.value) {
            currentUser = await homeService.getUserInfo();
          }

          emit(HomeSuccess(response));
        } catch (e) {
          emit(HomeError('خطا ناشناس'));
        }
      }
    });
  }
}
