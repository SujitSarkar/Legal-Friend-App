import 'package:flutter/material.dart';
import 'package:legal_friend/variables/pColor.dart';

// ignore: must_be_immutable
class HomeMainButton extends StatefulWidget {
  Function onPressed;
  String image;
  HomeMainButton({this.image,this.onPressed});

  @override
  _HomeMainButtonState createState() => _HomeMainButtonState();
}

class _HomeMainButtonState extends State<HomeMainButton> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onPressed,
      child: Ink(
        height: size.width*.4,
        width: size.width*.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size.width*.03)),
          border: Border.all(
            color: Colors.grey,
            width: 3.0
          ),
          image: DecorationImage(
            image: AssetImage(widget.image),
            fit: BoxFit.fitHeight
          )
        ),
      ),
      borderRadius: BorderRadius.all(Radius.circular(size.width*.03)),
      splashColor: PColor.livePageBgColor.withOpacity(0.5),
    );
  }
}
