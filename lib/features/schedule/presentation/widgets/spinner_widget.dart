import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({
    @required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
