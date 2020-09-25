
import 'dart:ui';

import 'package:flutter/material.dart';

const kapiUrl= "http://10.0.2.2:3000/api";
const kPrimaryColor = Color(0xFFee8325);
const kPrimaryLightColor = Color(0xFFFFFFFF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFFfac430), Color(0xFFee8325)],
);
const kSecondaryColor = Color(0xFF373330);
const kOtherColor= Color(0xFFfac430);
const kAnimationDuration = Duration(milliseconds: 200); //No poner ip 127.0.0.1 ni localhost
var token="";