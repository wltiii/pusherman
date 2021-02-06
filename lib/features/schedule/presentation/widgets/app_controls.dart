import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_bloc.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_event.dart';

class AppControls extends StatefulWidget {
  const AppControls({
    Key key,
  }) : super(key: key);

  @override
  _AppControlsState createState() => _AppControlsState();
}

class _AppControlsState extends State<AppControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<PillBoxSetBloc>(context)
        .add(GetPillBoxSetForDependent('Bill'));
  }
}