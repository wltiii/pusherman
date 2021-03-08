import 'package:meta/meta.dart';

import 'package:pusherman/features/schedule/domain/entities/pill.dart';

class PillModel extends Pill {
  PillModel({
    required String name,
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