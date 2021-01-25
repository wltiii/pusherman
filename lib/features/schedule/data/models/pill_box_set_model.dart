import 'package:meta/meta.dart';

import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'pill_box_model.dart';

class PillBoxSetModel extends PillBoxSet /*implements JsonModel<PillBoxSetModel>*/ {
  final List<PillBoxModel> pillBoxes;

  PillBoxSetModel({
    @required String dependent,
    @required List<String> caretakers,
    @required this.pillBoxes
  }) : super(
    dependent: dependent,
    caretakers: caretakers,
    pillBoxes: pillBoxes
  );

  factory PillBoxSetModel.fromJson(Map<String, dynamic> json) {
    return PillBoxSetModel(
      dependent: json['dependent'],
      caretakers: json['caretakers'].cast<String>(),
      pillBoxes: json['pillBoxes']
          .map((pillBox) => PillBoxModel.fromJson(pillBox))
          .toList()
          .cast<PillBoxModel>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dependent": dependent,
      "caretakers": caretakers,
      "pillBoxes": (pillBoxes).map((pillBox) => pillBox.toJson()).toList(),
    };
  }
}