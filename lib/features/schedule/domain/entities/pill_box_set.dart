import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'pill_box.dart';

class PillBoxSet extends Equatable {
  final String dependent;
  final List<PillBox> pillBoxes;

  PillBoxSet({
    @required this.dependent,
    @required this.pillBoxes
  });

  @override
  List<Object> get props => [dependent, pillBoxes];

  @override
  bool get stringify => true;
}
