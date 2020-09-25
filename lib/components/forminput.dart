import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../sizeConfig.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isContrasena;
  final Function onSubmit;
  final List<BoxShadow> sombras;

  const FormInput(
      {Key key,
      this.controller,
      this.hintText,
      this.isContrasena,
      this.onSubmit,
      this.sombras})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(250),
      height: getProportionateScreenHeight(40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: sombras),
      clipBehavior: Clip.hardEdge,
      child: TextFormField(
        onFieldSubmitted: onSubmit,
        controller: controller,
        obscureText: isContrasena,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: hintText,
            fillColor: kPrimaryLightColor,
            filled: true,
            border: InputBorder.none),
      ),
    );
  }
}
