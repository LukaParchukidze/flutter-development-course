import 'package:flutter/material.dart';
import 'package:assignment_01/planet.dart';

const planets = <Planet>[
  Planet(
    "Earth",
    "https://upload.wikimedia.org/wikipedia/commons/7/7b/Earth_Western_Hemisphere.jpg",
  ),
  Planet(
    "Neptune",
    "https://www.nasa.gov/sites/default/files/thumbnails/image/neptune1.png",
  ),
  Planet(
    "Mars",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/1200px-OSIRIS_Mars_true_color.jpg",
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Three Planets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ThreePlanets(),
    );
  }
}

class ThreePlanets extends StatefulWidget {
  @override
  _ThreePlanetsState createState() => _ThreePlanetsState();
}

class _ThreePlanetsState extends State<ThreePlanets> {
  Planet planet = planets.first;

  void _setPlanet(Planet planet) {
    setState(() {
      this.planet = planet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Three Planets'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(planet.name, style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 24,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              planet.url,
              height: 256,
              width: 256,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              planets.length,
              (index) => ElevatedButton(
                onPressed: () => _setPlanet(planets[index]),
                child: Text(
                  planets[index].name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
