import 'package:midterm_01/data/models/car_model.dart';
import 'package:midterm_01/data/models/dummy_data.dart';

class CarRepository {
  void addCar(Car car) {
    cars.add(car);
  }

  void removeCar(int id) {
    cars.removeWhere((element) => element.id == id);
  }

  void editCar(Car car, int index) {
    cars.replaceRange(index, index + 1, [car]);
  }
}
