import 'dart:convert';

import 'package:http/http.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Articulo.dart';
import 'package:mechany/Model/Tienda.dart';
import 'package:mechany/components/forminput.dart';
import 'package:mechany/screens/listaAccesorios/components/AccesoriosCard.dart';
import 'package:mechany/screens/listaMecanicos/components/MecanicoCard.dart';
import 'package:mechany/sizeConfig.dart';
import 'package:flutter/material.dart';

class ListaAccesorios extends StatefulWidget {
  
  ListaAccesorios({Key key}) : super(key: key);

  @override
  _ListaAccesoriosState createState() => _ListaAccesoriosState();
}

class _ListaAccesoriosState extends State<ListaAccesorios> {
List<Articulo> articulos;
@override
  void initState() {
     this.getArticulos();
    super.initState();
  }

@override
  Widget build(BuildContext context) {
   
    return Scaffold(
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
                              Icons.settings,
                              color: kPrimaryColor,
                              size: getProportionateScreenHeight(100),
                            ),
                          ),
                        ),
                        Text(
                          "Respuestos y Accesorios",
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
    return ListView.builder(
      itemCount: articulos.length,
      itemBuilder: (context,index){
        return AccesorioCard(articulo: articulos[index],);
      });
  }
}

  Future<void> getArticulos() async{
  try{
  Response response= await get("${kapiUrl}/articulo");
  if(response.statusCode==400){
    Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error al obtener articulos')));
    
  }else{
    var jsonData= jsonDecode(response.body);
    List<Articulo> articulos=[];
    for (var  artJson in jsonData ) {
      Articulo articulo= Articulo(
        codigoArticulo:artJson["idArticulo"],
        nombre: artJson["articulo"],
        calificacion: artJson["calificacion"],
        costo: artJson["costo"],
        marca: artJson["marca"],
        cantidad: artJson["cantidad"],
        descripcion: artJson["descripcion"],
        tienda: Tienda(
          codigo: artJson["TiendaArticulo"]["idTienda"],
          nombre: artJson["TiendaArticulo"]["nombre"],
          direccion:artJson["TiendaArticulo"]["direccion"],
          latitud: artJson["TiendaArticulo"]["coordenaday"],
          longitud: artJson["TiendaArticulo"]["coordenadax"],
          telefono: artJson["TiendaArticulo"]["telefono"],
         )
        );
      articulos.add(articulo);
    }
    setState(() {
      this.articulos= articulos;
    });
  }
  }catch(e){
     Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error al obtener articulos')));
    setState(() {
      articulos=[];
    });
  }

}
}
  

