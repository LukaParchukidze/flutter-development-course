import 'package:assignment_06/data/models/planet.dart';
import 'package:assignment_06/data/repositories/planet_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'planet_state.dart';

class PlanetCubit extends Cubit<PlanetState> {
  PlanetCubit() : super(PlanetInitial());

  final planetRepo = PlanetRepository();

  Future<void> getPlanet(String path) async {
    emit(PlanetInitial());

    try {
      var planet = await planetRepo.fetchPlanet(path);
      emit(PlanetLoaded(planet: planet!));
    } catch (e) {
      emit(PlanetError(message: e.toString()));
    }
  }
}
