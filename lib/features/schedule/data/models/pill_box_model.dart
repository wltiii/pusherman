import 'package:meta/meta.dart';

import 'pill_model.dart';
import '../../domain/entities/pill_box.dart';

class PillBoxModel extends PillBox {
  final List<PillModel> pills;
  
  PillBoxModel({
    @required String name,
    @required String frequency,
    @required this.pills,
  }) : super(
    name: name,
    frequency: frequency,
    pills: pills
  );

  factory PillBoxModel.fromJson(Map<String, dynamic> json) {
    return PillBoxModel(
      name: json['name'],
      frequency: json['frequency'],
      pills: json['pills'].map((pill) => PillModel.fromJson(pill))
          .toList()
          .cast<PillModel>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "frequency": frequency,
      "pills": (pills).map((pill) => pill.toJson()).toList(),
    };
  }
}