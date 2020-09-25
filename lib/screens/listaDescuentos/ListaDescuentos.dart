import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Descuento.dart';
import 'package:mechany/Model/Tienda.dart';
import 'package:mechany/screens/listaDescuentos/components/DescuentoCard.dart';
import 'package:mechany/sizeConfig.dart';

class ListaDescuentos extends StatefulWidget {
  final Tienda tienda;
  
  ListaDescuentos({this.tienda});
  @override
  _ListaDescuentosState createState() => _ListaDescuentosState();
}

class _ListaDescuentosState extends State<ListaDescuentos> {
  List<Descuento> descuentos;

  @override
  void initState() {
    this.getDescuentos();
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
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/descuentos.jpeg"),fit: BoxFit.cover)),
                    child: 
                        Align(
                          alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom:8.0),
                              child: Text(
                              "Descuentos",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(40),
                                  color: kPrimaryLightColor,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    BoxShadow(color: Colors.black,offset: Offset(-2,1))
                                  ]
                                  ),
                          ),
                            ),
                        )
                    
                  ),
                ),
                Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(color: kPrimaryLightColor),
                        child: mostrarDescuentos()
                    ))
              ],
            ),
          
    ),
        );
  }

Widget mostrarDescuentos(){
  if (descuentos==null){
    return Center(child: CircularProgressIndicator());
  }
  else{
    if(descuentos.length==0){
      return Center(child: Text("No existen articulos en stock"),);
    }else{
      return ListView.builder(
      itemCount: descuentos.length,
      itemBuilder: (context,index){
        return DescuentoCard(descuento: descuentos[index],);
      });
    }
    
  }
}

  void getDescuentos() async{
    try{
      Response r= await get("${kapiUrl}/promocion/${widget.tienda.codigo}");
      if (r.statusCode==200){
        var json= jsonDecode(r.body);
        List<Descuento> descuentos=[];
        for(var jsonArt in json){
          Descuento descuento= Descuento(nombre: jsonArt["promocion"]);
          descuentos.add(descuento);
        }
        setState(() {
          this.descuentos=descuentos;
        });
      }else{
        setState(() {
          this.descuentos=[];
        });
      }
    }catch(e){
      setState(() {
          this.descuentos=[];
        });
    }
    

  }
}