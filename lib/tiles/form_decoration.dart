import 'package:flutter/material.dart';

InputDecoration boxFormDecoration(Size size) => InputDecoration(
  hintText: '',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: size.width*.04,
    fontWeight: FontWeight.w400,
      fontFamily: 'barkatFontBold'
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(size.width*.02)),
      borderSide: BorderSide(
          color: Colors.grey[800],
          width: 1.5
      )
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(size.width*.02)),
      borderSide: BorderSide(
          color: Colors.grey[800],
          width: 1.5
      )
  ),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(size.width*.02)),
      borderSide: BorderSide(
          color: Colors.grey[800],
          width: 1.5
      )
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(size.width*.02)),
      borderSide: BorderSide(
          color: Colors.grey[800],
          width: 1.5
      )
  ),
);