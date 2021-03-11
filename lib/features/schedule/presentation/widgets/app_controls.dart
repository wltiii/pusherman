import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusherman/features/schedule/presentation/blocs/pillboxset/bloc.dart';

class AppControls extends StatefulWidget {
  const AppControls({
    required Key key,
  }) : super(key: key);

  @override
  _AppControlsState createState() => _AppControlsState();
}

class _AppControlsState extends State<AppControls> {
  final controller = TextEditingController();
  // String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
    // ExpansionTile(
    //   title: Text(
    //       'Morning',
    //       style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
    //   ),
    //
    //   subtitle: Text(
    //     'Daily',
    //     style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)
    //   ),
    //     // onExpansionChanged: dispatchConcrete();
    // // children: [
    // // _buildDependent(dependent),
    // // _buildPillList(pillbox.pills),
    // // ]
    // ),
        // TextField(
        //   controller: controller,
        //   keyboardType: TextInputType.text,
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(),
        //     hintText: 'Input a number',
        //   ),
        //   onChanged: (value) {
        //     inputStr = value;
        //   },
        //   onSubmitted: (_) {
        //     dispatchConcrete();
        //   },
        // ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: IconButton(
                padding: const EdgeInsets.only(),
                icon: Icon(Icons.add_circle_outline),
                tooltip: 'Add treatments',
                onPressed: dispatchSetup,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchSetup() {
    // controller.clear();
    BlocProvider.of<PillBoxSetBloc>(context)
        .add(PillBoxSetupEvent());
  }

  Widget _showDrawer() {
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        )

    );

  }
}