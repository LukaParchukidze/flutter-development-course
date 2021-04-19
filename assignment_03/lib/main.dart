import 'package:flutter/material.dart';
import 'package:assignment_03/planet.dart';

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

  List<Widget> getButtons() {
    return List.generate(
      planets.length,
      (index) => Container(
        width: MediaQuery.of(context).size.width / 4,
        child: ElevatedButton(
          onPressed: () => _setPlanet(planets[index]),
          child: Text(
            planets[index].name,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Three Planets'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 500) {
            return ThreePlanetsPortraitLayout(
              planet: planet,
              buttons: getButtons(),
            );
          } else {
            return ThreePlanetsLandscapeLayout(
              planet: planet,
              buttons: getButtons(),
            );
          }
        },
      ),
    );
  }
}

class ThreePlanetsPortraitLayout extends StatelessWidget {
  const ThreePlanetsPortraitLayout({
    Key key,
    @required this.planet,
    @required this.buttons,
  }) : super(key: key);

  final Planet planet;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          children: buttons,
        )
      ],
    );
  }
}

class ThreePlanetsLandscapeLayout extends StatelessWidget {
  const ThreePlanetsLandscapeLayout({
    Key key,
    @required this.planet,
    @required this.buttons,
  }) : super(key: key);

  final Planet planet;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    planet.url,
                    height: 256,
                    width: 256,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(planet.name, style: TextStyle(fontSize: 24)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            )
          ],
        ),
      ),
    );
  }
}
