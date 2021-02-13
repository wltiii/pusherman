import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pusherman/features/schedule/presentation/widgets/message_widget.dart';

class InitialSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false, // TODO: after setting up caregiver, should be able to navigate back to previous view
        title: Text('Pusherman Setup'),
      ),
      body: Center(
        // height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            MessageWidget(
                key: Key('initial-doctor'),
                message: "I'm your doctor",
            ),
            // MessageWidget(
            //   key: Key('initial-pusherman'),
            //   message: "I'm your pusherman",
            // ),
            RaisedButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                );
                // Navigator.of(context).pushReplacementNamed(
                //   '/',
                //   arguments: 'Hello from the first page!',
                // );
              },
            )
          ]
        ),
      )
    );
  }
}