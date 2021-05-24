part of 'user_data_cubit.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataInitial extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoaded extends UserDataState {
  final List<User> userList;

  UserDataLoaded({required this.userList});

  @override
  List<Object?> get props => [userList];
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
