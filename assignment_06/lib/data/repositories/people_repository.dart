import 'package:assignment_06/data/models/people.dart';
import 'package:dio/dio.dart';

class PeopleRepository {
  List<People>? peopleList = [];
  Dio dio = Dio();

  Future<List<People>>? fetchPeople() async {
    final response = await dio.get('https://swapi.dev/api/people/');
    if (response.statusCode == 200) {
      response.data['results']
          .forEach((people) => peopleList!.add(People.fromJson(people!)));
    }

    return peopleList!;
  }
}
