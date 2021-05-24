import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:assignment_05/data/models/user.dart';
import 'package:assignment_05/data/repositories/user_repository.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  final userRepo = UserRepository();

  Future<void> getUserData() async {
    try {
      var list = await userRepo.fetchUsers();
      emit(UserDataLoaded(userList: list!));
    } catch (e) {
      emit(UserDataError(message: e.toString()));
    }
  }
}
