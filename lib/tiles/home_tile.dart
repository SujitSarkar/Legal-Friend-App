import 'package:flutter/material.dart';

class HomeMainButton extends StatelessWidget {
  const HomeMainButton({Key key,
    @required this.image, @required this.onPressed,@required this.bgColor}) : super(key: key);
  final Function onPressed;
  final String image;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: size.width*.35,
        padding: EdgeInsets.all(size.width*.04),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(size.width*.03))),
        child: Image.asset(image,fit: BoxFit.cover),
      ),
      borderRadius: BorderRadius.all(Radius.circular(size.width*.03)),
    );
  }
}
