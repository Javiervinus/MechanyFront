import 'package:flutter/material.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Articulo.dart';
import 'package:mechany/sizeConfig.dart';

class StockCard extends StatelessWidget {
  final Articulo articulo;
  const StockCard({Key key,this.articulo}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(getProportionateScreenHeight(5)),
      child: GestureDetector(
          onTap: (){
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
                      Text(articulo.nombre,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: getProportionateScreenHeight(25),fontWeight: FontWeight.bold),),
                      Text("\$${articulo.costo}",style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: getProportionateScreenHeight(15)))
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