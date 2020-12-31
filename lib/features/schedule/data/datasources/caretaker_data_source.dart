import '../models/caretaker_model.dart';

abstract class CaretakerDataSource {
  Future<CaretakerModel> get(String name);
  Future<void> put(CaretakerModel caretakerModel);
}
