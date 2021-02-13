import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/widgets/app_controls.dart';

import 'package:pusherman/service_locator.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_bloc.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_state.dart';
import 'package:pusherman/features/schedule/presentation/widgets/message_widget.dart';
import 'package:pusherman/features/schedule/presentation/widgets/pill_box_set_widget.dart';
import 'package:pusherman/features/schedule/presentation/widgets/spinner_widget.dart';

class DependentPillBoxesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Pusherman3'),
      ),
      // body: SingleChildScrollView(
      //     child: buildPillBoxSetBody(context)
      // ),
      body: buildPillBoxSetBody(context)
      // body: Text('body is here')
    );
  }

  BlocProvider<PillBoxSetBloc> buildPillBoxSetBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<PillBoxSetBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget> [
              // buildMessageWidget(),
              BlocBuilder<PillBoxSetBloc, PillBoxSetState>(
                builder: (context, state) {
                  // TODO do not case like this!
                  if (state is PillBoxSetEmpty) {
                    return MessageWidget(message: "I'm your friend.");
                    // return PillBoxesSetWidget(
                    //     key: Key('PillBoxesSetWidget'),
                    //     pillBoxSet: PillBoxSet(dependent: '', caretakers: [''], pillBoxes: [])
                    // );

                  }
                  else if (state is PillBoxSetLoading) {
                    //return SpinnerWidget();
                    // return Text('two');
                    return MessageWidget(message: "I'm your doctor");
                  }
                  else if (state is PillBoxSetLoaded) {
                    return MessageWidget(message: "I'm your pusherman");
                    // return PillBoxesSetWidget(
                    //     key: Key('PillBoxesSetWidget'),
                    //     pillBoxSet: state.pillBoxSet
                    // );
                  }
                  else if (state is PillBoxSetError) {
                    return Text('four');
                    //return MessageWidget(message: 'error view');
                    //return MessageWidget(message: state.message);
                  }
                  else{
                    //return MessageWidget(message: 'subsequent view');
                    return Text('five');
                  }
                }
              ),
                // AppControls()
              PillBoxesSetWidget(
                  key: Key('PillBoxesSetWidget'),
                  pillBoxSet: PillBoxSet(dependent: '', caretakers: [''], pillBoxes: [])
              )
            ]
          ),
        )
      )
      // child: ListView(
      //   children: _pillSets.pillBoxes.map((set) => _buildSetItem( set, _pillSets.dependent)).toList(),
      // ),
    );
  }

  // MessageWidget buildMessageWidget() => MessageWidget(key: Key('message-widget'), message: 'initial view');
  // DependentPillBoxesPage({Key key, this.title}) : super(key: key);

  // final String title;
  //
  // @override
  // _DependentPillBoxesPageState createState() => _DependentPillBoxesPageState();

}