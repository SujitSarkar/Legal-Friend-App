import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomTile extends StatefulWidget {
  @override
  _BottomTileState createState() => _BottomTileState();
}
class _BottomTileState extends State<BottomTile> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 500), //center button animation duration
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);
    Future.delayed(
      Duration(seconds: 1),
          () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onTap: () {
          _animationController.reset();
          _animationController.forward();
        },
        child: Container(
          width: size.width,
          height: size.width * .15,
          //color: Colors.red,
          child: Image.asset('assets/logo/splash_image.png'),
        ),
      ),
    );
  }
}
