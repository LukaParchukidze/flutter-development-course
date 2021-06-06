part of 'planet_cubit.dart';

abstract class PlanetState extends Equatable {
  const PlanetState();
}

class PlanetInitial extends PlanetState {
  @override
  List<Object> get props => [];
}

class PlanetLoaded extends PlanetState {
  final Planet planet;

  PlanetLoaded({required this.planet});

  @override
  List<Object?> get props => [planet];
}

class PlanetError extends PlanetState {
  final String message;

  PlanetError({required this.message});

  @override
  List<Object?> get props => [message];
}
