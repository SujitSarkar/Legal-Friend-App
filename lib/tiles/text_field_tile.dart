import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/form_decoration.dart';

class TextFieldBuilder extends StatefulWidget {
  TextFieldBuilder({Key key,
    @required this.controller,
    this.hintText,
    this.labelText,
    this.fillColor,
    this.obscure=false,this.textInputType,this.textCapitalization}) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final bool obscure;
  final Color fillColor;

  @override
  _TextFieldBuilderState createState() => _TextFieldBuilderState();
}

class _TextFieldBuilderState extends State<TextFieldBuilder> {
  bool _obscure=true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscure? _obscure:false,
      keyboardType: widget.textInputType??TextInputType.text,
      textCapitalization: widget.textCapitalization??TextCapitalization.none,
      style: TextStyle(
        color: Colors.grey.shade900,
        fontSize: size.width*.045,
        fontWeight: FontWeight.w400,
      ),
      decoration: newDecoration(size).copyWith(
        fillColor: widget.fillColor??null,
        filled: widget.fillColor!=null?true:false,
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.obscure
              ? InkWell(
            onTap: ()=>setState(()=> _obscure=!_obscure),
            child: Padding(
              padding: EdgeInsets.only(right: size.width*.04),
              child: Icon(_obscure?CupertinoIcons.eye_slash:CupertinoIcons.eye,
                  size: size.width*.06,
                  color: Colors.grey),
            ),
          ) : null
      ),
    );
  }
}
