import 'package:assignment_06/logic/cubits/planet/planet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanetScreen extends StatelessWidget {
  const PlanetScreen({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planet')),
      body: BlocConsumer<PlanetCubit, PlanetState>(
        listener: (context, state) {
          if (state is PlanetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is PlanetInitial) {
            BlocProvider.of<PlanetCubit>(context).getPlanet(path);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlanetLoaded) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Name: ${state.planet.name!}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Rotation Period: ${state.planet.rotationPeriod!}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Orbital Period: ${state.planet.orbitalPeriod!}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Diameter: ${state.planet.diameter!}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Climate: ${state.planet.climate!}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Population: ${state.planet.population!}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ));
          } else {
            return Center(
              child: Text('Ops! Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
