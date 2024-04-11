import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/modeels/user.dart';
import 'package:vesam_shop/data/services/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;
  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      //comment
      if (event is UserCommentsScreenStarted) {
        emit(UserCommentsLoding());
        try {
          var response = await profileService.getUserComments();
          emit(UserCommentsSuccess(response));
        } catch (e) {
          emit(UserCommentsError('خطای نامشخص'));
        }
      }

      //payments
      if (event is UserPaymentsScreenStarted) {
        emit(UserPaymentsLoding());
        try {
          var response = await profileService.getUserPayment();
          emit(UserPaymentsSuccess(response));
        } catch (e) {
          emit(UserPaymentsError('خطای نامشخص'));
        }
      }
    });
  }
}
