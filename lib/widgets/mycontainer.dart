import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double _marginValue;
  // final double _height;
  final double _borderRadius;
  final Color _color;
  final Widget _child;

  const MyContainer(this._marginValue,  this._borderRadius, this._color, this._child,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_marginValue),
      padding: EdgeInsets.all(10),
      //height: _height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(_borderRadius),
        color: _color,
      ),
      child: _child,
    );
  }
}
