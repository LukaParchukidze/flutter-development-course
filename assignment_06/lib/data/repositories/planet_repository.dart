import 'package:assignment_06/data/models/planet.dart';
import 'package:dio/dio.dart';

class PlanetRepository {
  Planet planet = Planet();
  Dio dio = Dio();

  Future<Planet>? fetchPlanet(String path) async {
    var response = await dio.get(path);
    if (response.statusCode == 200) {
      var loadedPlanet = Planet.fromJson(response.data);

      planet = loadedPlanet;
      return planet;
    }
    return planet;
  }
}
