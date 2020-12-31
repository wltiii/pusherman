import 'package:meta/meta.dart';
import '../../domain/entities/caretaker.dart';

class CaretakerModel extends Caretaker {

  CaretakerModel({
    @required String name,
    @required dependents,
  }) : super(
    name: name, dependents: dependents
  );

  factory CaretakerModel.fromJson(Map<String, dynamic> json) {
    return CaretakerModel(
      name: json['name'],
      dependents: json['dependents'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "dependents": dependents,
    };
  }
}