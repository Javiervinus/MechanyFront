import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Constants.dart';
import '../sizeConfig.dart';
import '../sizeConfig.dart';
import '../sizeConfig.dart';
import '../sizeConfig.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: getProportionateScreenHeight(75),
      backgroundColor: kPrimaryLightColor,
      child: Text(
        "M",
        style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenHeight(80),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
