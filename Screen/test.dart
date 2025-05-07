import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/Custom_widget/chatwidget/ChatTextfiled.dart';
import 'package:untitled4/constans.dart';

class AnimatedContainerApp extends StatefulWidget {
  AnimatedContainerApp({super.key, required this.Child});
  Widget Child;
  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 100;
  final double _height = 40;
  final Color _color = KLSecondarycolor;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutBack,
      child: GestureDetector(
          onTap: () {
            print(_width);
            _width = 240;
            
            setState(() {});
          },
          child: _width == 240 ? widget.Child : null),
    );
  }
}
