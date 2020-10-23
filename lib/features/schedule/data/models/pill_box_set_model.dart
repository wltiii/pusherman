import 'package:meta/meta.dart';
import 'package:pusherman/features/schedule/data/models/json_model.dart';
import 'pill_box_model.dart';

import 'pill_model.dart';
import '../../domain/entities/pill_box_set.dart';

class PillBoxSetModel extends PillBoxSet /*implements JsonModel<PillBoxSetModel>*/ {
  final List<PillBoxModel> pillBoxes;

  PillBoxSetModel({
    @required String dependent,
    @required this.pillBoxes
  }) : super(
      dependent: dependent,
    pillBoxes: pillBoxes
  );

  factory PillBoxSetModel.fromJson(Map<String, dynamic> json) {
    return PillBoxSetModel(
      dependent: json['dependent'],
      pillBoxes: json['pillBoxes']
          .map((pillBox) => PillBoxModel.fromJson(pillBox))
          .toList()
          .cast<PillBoxModel>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dependent": dependent,
      "pillBoxes": (pillBoxes).map((pillBox) => pillBox.toJson()).toList(),
    };
  }
}