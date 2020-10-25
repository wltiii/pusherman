import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';

abstract class CaretakerDataSource {
  Future<CaretakerModel> get(String name);
  Future<void> put(CaretakerModel caretakerModel);
}
