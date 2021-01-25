import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

class PillBoxesSetWidget extends StatelessWidget {
  final PillBoxSet pillBoxSet;

  const PillBoxesSetWidget({
    @required Key key,
    @required this.pillBoxSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Widget> widgets = [];
    // pillBoxSet.pillBoxes.forEach((pillBox) =>
    //     widgets.add(_buildSetItem(pillBox, pillBoxSet.dependent))
    // );
    // List<Widget> widgets = pillBoxSet.pillBoxes.map((box) => _buildPillItem)
    //     .toList() as List<Widget>;
    // return Column(
    //   children: widgets,
    // );
    return Column(
      children: pillBoxSet.pillBoxes.map((box) => _buildPillItem)
          .toList() as List<Widget>,
    );
  }

  Widget _buildSetItem(PillBox pillbox, String dependent) {
//    return _buildSetHeader(set);
    return ExpansionTile(
        title: _buildSetTitle(pillbox),
        subtitle: _buildSetSubtitle(pillbox),
        children: [
          _buildDependent(dependent),
          _buildPillList(pillbox.pills),
        ]
    );
  }

  Widget _buildSetTitle(PillBox pillbox) {
    return Text(
        pillbox.name,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
    );
  }

  Widget _buildSetSubtitle(PillBox pillbox) {
    return Text(
        pillbox.frequency,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)
    );
  }

  Widget _buildDependent(String dependent) {
    return Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
              "Dependent: $dependent",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)
          ),
        ]
    );
  }

  Widget _buildPillList(List pills) {
    return ExpansionTile(
      title: Text('Pills'),
      children: pills.map((pill) => _buildPillItem(pill)).toList(),
    );
  }

  Widget _buildPillItem(String pill) {
    return Text(
        pill,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)
    );
  }
}