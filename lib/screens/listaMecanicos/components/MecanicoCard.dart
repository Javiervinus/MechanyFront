import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mechany/Model/Mecanico.dart';
import 'package:mechany/screens/mecanicoDetails/MecanicoDetails.dart';

import '../../../Constants.dart';
import '../../../sizeConfig.dart';

class MecanicoCard extends StatelessWidget {
  final Mecanico mecanico;
  const MecanicoCard({Key key,this.mecanico}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(getProportionateScreenHeight(5)),
      child: GestureDetector(
          onTap: (){
            MaterialPageRoute route= MaterialPageRoute(builder: (_)=>MecanicoDetails(mecanico: this.mecanico,));
            Navigator.of(context).push(route);
          },
          child: Container(
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            boxShadow: [
              BoxShadow(color:Colors.black.withOpacity(0.2),offset: Offset(1,3))
            ],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:getProportionateScreenHeight(20)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenHeight(20)),
                  child: CircleAvatar(
                    radius: getProportionateScreenHeight(30),
                    child: Image.asset("assets/img/mecanico.jpg"),
                    backgroundColor: kPrimaryColor,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mecanico.nombre,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: getProportionateScreenHeight(25),fontWeight: FontWeight.bold),),
                      Text(mecanico.direccion,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: getProportionateScreenHeight(15)))
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