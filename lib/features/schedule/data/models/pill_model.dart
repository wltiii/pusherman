import 'package:meta/meta.dart';

import '../../domain/entities/pill.dart';

class PillModel extends Pill {
  PillModel({
    @required String name,
  }) : super(name: name);

  factory PillModel.fromJson(Map<String, dynamic> json) {
    return PillModel(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}