import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:user_infromation_bloc/model/UserModel.dart';

@immutable
abstract class UserState extends Equatable {}

//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedListState extends UserState {
  final List<UserModel> users;
  UserLoadedListState(this.users);
  @override
  List<Object?> get props => [users];
}

class UserLoadedObjectState extends UserState {
  final UserModel users;
  UserLoadedObjectState(this.users);
  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
