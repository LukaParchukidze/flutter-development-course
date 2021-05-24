import 'package:dio/dio.dart';
import 'package:assignment_05/data/models/user.dart';

class UserRepository {
  List<User>? userList = [];
  Dio dio = Dio();

  Future<List<User>>? fetchUsers() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      var loadedUsers = <User>[];
      response.data.forEach((user) {
        var userModel = User.fromJson(user);
        loadedUsers.add(userModel);
        userList = loadedUsers;
        return userList!;
      });
    }
    return userList!;
  }
}
