import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_infromation_bloc/viewModel/GetUserInformation.dart';
import 'package:user_infromation_bloc/viewModel/LoadedState.dart';
import 'package:user_infromation_bloc/viewModel/LoadingEvent.dart';

class UserBlocService extends Bloc<UserEvent, UserState> {

  final GetUserInformation getUserInformation;

  int userID;

  UserBlocService(this.getUserInformation, this.userID) : super(UserLoadingState()) {
    on<LoadingEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await getUserInformation.getUsers();
        emit(UserLoadedListState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }

  UserBlocService.details(this.getUserInformation, this.userID) : super(UserLoadingState()) {
    on<LoadingEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await getUserInformation.getUserDetails(userID);
        emit(UserLoadedObjectState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}