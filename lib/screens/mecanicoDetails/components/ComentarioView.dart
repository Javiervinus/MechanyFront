import 'package:flutter/material.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/sizeConfig.dart';

class ComentarioView extends StatelessWidget {
  final String comentario;
  const ComentarioView({Key key,this.comentario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
        child: Container(
          height: getProportionateScreenHeight(40),
          width: getProportionateScreenWidth(250),
          decoration: BoxDecoration(color: kPrimaryLightColor,borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(comentario),
            ),
        ),
      ),
    );
  }
}