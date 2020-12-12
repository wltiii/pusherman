import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';
import '../bloc/pill_box_set_bloc.dart';
import '../bloc/pill_box_set_state.dart';
import '../widgets/message_widget.dart';
import '../widgets/pill_box_set_widget.dart';
import '../widgets/spinner_widget.dart';

class DependentPillBoxesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Pusherman'),
      ),
      body: buildPillBoxSetBody(context)
    );
  }

  BlocProvider<PillBoxSetBloc> buildPillBoxSetBody(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PillBoxSetBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget> [
              BlocBuilder<PillBoxSetBloc, PillBoxSetState>(
                builder: (context, state) {
                  // TODO do not case like this!
                  if (state is PillBoxSetEmpty) {
                    return MessageWidget(message: 'initial view');
                  }
                  else if (state is PillBoxSetLoading) {
                    return SpinnerWidget();
                  }
                  else if (state is PillBoxSetLoaded) {
                    return PillBoxesSetWidget(pillBoxSet: state.pillBoxSet);
                  }
                  else if (state is PillBoxSetError) {
                    return MessageWidget(message: state.message);
                  }
                }
              ),

            ]
          ),
        )
      )
      // child: ListView(
      //   children: _pillSets.pillBoxes.map((set) => _buildSetItem( set, _pillSets.dependent)).toList(),
      // ),
    );
  }
  // DependentPillBoxesPage({Key key, this.title}) : super(key: key);

  // final String title;
  //
  // @override
  // _DependentPillBoxesPageState createState() => _DependentPillBoxesPageState();

}


