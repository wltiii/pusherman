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
    // print('building...');
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Pusherman3'),
      ),
      // body: SingleChildScrollView(
      // child: buildPillBoxSetBody(context)
      // )
      body: buildPillBoxSetBody(context)
      // body: Text('body is here')
    );
  }

  BlocProvider<PillBoxSetBloc> buildPillBoxSetBody(BuildContext context) {
    print("buildPillBoxSetBody");
    return BlocProvider(
      create: (_) => sl<PillBoxSetBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget> [
              // Text('child1'),
              // Text('child2'),
             //MessageWidget(message: 'initial view')
              BlocBuilder<PillBoxSetBloc, PillBoxSetState>(
                builder: (context, state) {
                  print('BlocBuilder.builder');
                  // TODO do not case like this!
                  if (state is PillBoxSetEmpty) {
                    //return MessageWidget(message: 'initial view');
                    print('BlocBuilder.builder: PillBoxSetEmpty');
                    return Text('one');
                  }
                  else if (state is PillBoxSetLoading) {
                    //return SpinnerWidget();
                    print('BlocBuilder.builder: PillBoxSetLoading');
                    return Text('two');
                    //return MessageWidget(message: 'loading view');
                  }
                  else if (state is PillBoxSetLoaded) {
                    //return MessageWidget(message: 'loaded view');
                    print('BlocBuilder.builder: PillBoxSetLoaded');
                    return Text('three');
                    //return PillBoxesSetWidget(pillBoxSet: state.pillBoxSet);
                  }
                  else if (state is PillBoxSetError) {
                    print('BlocBuilder.builder: PillBoxSetError');
                    return Text('four');
                    //return MessageWidget(message: 'error view');
                    //return MessageWidget(message: state.message);
                  }
                  else{
                    //return MessageWidget(message: 'subsequent view');
                    print('BlocBuilder.builder: why am i here');
                    return Text('five');
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


