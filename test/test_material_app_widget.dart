import 'package:flutter/material.dart';

class TestMaterialAppWidget extends StatelessWidget {
  TestMaterialAppWidget({this.home});
  final Widget? home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Test',
      home: home,
    );
  }
}
