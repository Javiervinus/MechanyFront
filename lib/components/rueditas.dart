import 'package:flutter/material.dart';

import '../sizeConfig.dart';

class RueditasFondo extends StatelessWidget {
  const RueditasFondo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(60)),
      child: Image.asset("assets/img/rueditas.png"),
    );
  }
}
