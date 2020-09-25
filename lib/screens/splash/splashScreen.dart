import 'package:flutter/material.dart';

import '../../sizeConfig.dart';
import '../../sizeConfig.dart';
import '../../sizeConfig.dart';
import '../login/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/img/1.jpg',
              ),
              fit: BoxFit.fill)),
      child: Center(
        child: GestureDetector(
          onTap: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Login());
            Navigator.push(context, route);
          },
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white.withOpacity(0), width: 3)),
            width: getProportionateScreenWidth(205),
            height: getProportionateScreenHeight(52),
          ),
        ),
      ),
    );
  }
}
