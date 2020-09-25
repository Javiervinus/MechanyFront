import 'package:mechany/components/logo.dart';
import 'package:mechany/screens/Register/components/RegisterForm.dart';
import 'package:mechany/sizeConfig.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(gradient: kPrimaryGradientColor),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(40)),
                  child: Logo(),
                ),
                RegisterForm()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
