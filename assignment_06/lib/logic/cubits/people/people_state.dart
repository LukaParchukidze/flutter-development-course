part of 'people_cubit.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();
}

class PeopleInitial extends PeopleState {
  @override
  List<Object> get props => [];
}

class PeopleLoaded extends PeopleState {
  final List<People> peopleList;

  PeopleLoaded({required this.peopleList});

  @override
  List<Object?> get props => [peopleList];
}

class PeopleError extends PeopleState {
  final String message;

  PeopleError({required this.message});

  @override
  List<Object?> get props => [message];
}
