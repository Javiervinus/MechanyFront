import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Articulo.dart';
import 'package:mechany/screens/articuloDetails/ArticuloDetails.dart';
import 'package:mechany/sizeConfig.dart';
import 'package:flutter/material.dart';

class AccesorioCard extends StatelessWidget {
  final Articulo articulo;
  const AccesorioCard({Key key,this.articulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding:  EdgeInsets.all(getProportionateScreenHeight(5)),
      child: GestureDetector(
          onTap: (){
            MaterialPageRoute route= MaterialPageRoute(builder: (_)=>ArticuloDetails(articulo: this.articulo,));
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
                    backgroundImage: AssetImage("assets/img/accesorio.jpg"),
                    backgroundColor: kPrimaryColor,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(articulo.nombre,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: getProportionateScreenHeight(24),fontWeight: FontWeight.bold),),
                      Text(articulo.tienda.direccion,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: getProportionateScreenHeight(20)))
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
