import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final double borderRadius;
  final double height;
  final double width;
  final List<Color> gradientColors;
  const GradientButton({
      this.child, this.onPressed, this.borderRadius, this.height, this.width,this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius??100.0)),
          ),
        ),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius??100.0)),
          ),
          child: Center(
            child: child,
          ),
          ),
        );
  }
}
