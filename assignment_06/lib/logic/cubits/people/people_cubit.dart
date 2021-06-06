import 'package:assignment_06/data/models/people.dart';
import 'package:assignment_06/data/repositories/people_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());

  final peopleRepo = PeopleRepository();

  Future<void> getPeopleData() async {
    try {
      var list = await peopleRepo.fetchPeople();
      emit(PeopleLoaded(peopleList: list!));
    } catch (e) {
      emit(PeopleError(message: e.toString()));
    }
  }
}
