import 'package:assignment_06/logic/cubits/people/people_cubit.dart';
import 'package:assignment_06/logic/cubits/planet/planet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: BlocConsumer<PeopleCubit, PeopleState>(
        listener: (context, state) {
          if (state is PeopleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PeopleInitial) {
            BlocProvider.of<PeopleCubit>(context).getPeopleData();
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PeopleLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var people = state.peopleList[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/planet-screen',
                      arguments: people.homeworld,
                    );
                    BlocProvider.of<PlanetCubit>(context).emit(PlanetInitial());
                  },
                  title: Text(people.name!),
                  subtitle: Text(people.birthYear!),
                );
              },
              itemCount: state.peopleList.length,
            );
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
