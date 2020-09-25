import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Articulo.dart';
import 'package:mechany/Model/Tienda.dart';
import 'package:mechany/screens/stockTienda/component/StockCard.dart';
import 'package:mechany/sizeConfig.dart';

class StockTienda extends StatefulWidget {
  final Tienda tienda;
  
  StockTienda({this.tienda});
  @override
  _StockTiendaState createState() => _StockTiendaState();
}

class _StockTiendaState extends State<StockTienda> {
  List<Articulo> articulos;

  @override
  void initState() {
    this.getArticulos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return 
        Scaffold(
                  body: Container(
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(gradient: kPrimaryGradientColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(30)),
                          child: CircleAvatar(
                            backgroundColor: kPrimaryLightColor,
                            radius: getProportionateScreenHeight(75),
                            child: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                              size: getProportionateScreenHeight(100),
                            ),
                          ),
                        ),
                        Text(
                          "Stock",
                          style: TextStyle(
                              fontSize: 30,
                              color: kPrimaryLightColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(color: kPrimaryLightColor),
                        child: mostrarArticulos()
                    ))
              ],
            ),
          
    ),
        );
  }

Widget mostrarArticulos(){
  if (articulos==null){
    return Center(child: CircularProgressIndicator());
  }
  else{
    if(articulos.length==0){
      return Center(child: Text("No existen articulos en stock"),);
    }else{
      return ListView.builder(
      itemCount: articulos.length,
      itemBuilder: (context,index){
        return StockCard(articulo: articulos[index],);
      });
    }
    
  }
}

  void getArticulos() async{
    try{
      Response r= await get("${kapiUrl}/articulo/tienda/${widget.tienda.codigo}");
      if (r.statusCode==200){
        var json= jsonDecode(r.body);
        List<Articulo> articulos=[];
        for(var jsonArt in json){
          Articulo articulo= Articulo(codigoArticulo: jsonArt["idArticulo"],nombre:jsonArt["articulo"],costo: jsonArt["costo"]);
          articulos.add(articulo);
        }
        setState(() {
          this.articulos=articulos;
        });
      }else{
        setState(() {
          this.articulos=[];
        });
      }
    }catch(e){
      setState(() {
          this.articulos=[];
        });
    }
    

  }
}