import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: SpinKitChasingDots(
          color: Colors.yellow,
          size: 50.0,
        ),
      ),
    );
  }
}


Widget loadi(){
  return SpinKitChasingDots(
    color: Colors.yellow,
    size: 50.0,
  );
}