import 'package:flutter/material.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Descuento.dart';
import 'package:mechany/sizeConfig.dart';

class DescuentoCard extends StatelessWidget {
  final Descuento descuento;
  const DescuentoCard({Key key, this.descuento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(5)),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryLightColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2), offset: Offset(1, 3))
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(20)),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenHeight(20)),
                  child: CircleAvatar(
                    radius: getProportionateScreenHeight(30),
                    backgroundImage: AssetImage("assets/img/mecanico.jpg"),
                    backgroundColor: kPrimaryColor,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: getProportionateScreenWidth(200),
                          child: Text(
                            descuento.nombre,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: getProportionateScreenHeight(24),
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
