import 'dart:convert';

import 'package:http/http.dart';
import 'package:mechany/Model/Mecanico.dart';
import 'package:mechany/screens/listaMecanicos/components/MecanicoCard.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../sizeConfig.dart';

class ListaMecanicos extends StatefulWidget {
  TextEditingController filtroController = TextEditingController(text: "");
  List<Mecanico> mecanicos;
  ListaMecanicos({Key key}) : super(key: key);

  @override
  _ListaMecanicosState createState() => _ListaMecanicosState();
}

class _ListaMecanicosState extends State<ListaMecanicos> {
  @override
  void initState() {
    this.getMecanicos();
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
                          "Personal Mecanico",
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
                        child: mostrarMecnicos()
                    ))
              ],
            ),
          
    ),
        );
  }

Widget mostrarMecnicos(){
  if (widget.mecanicos==null){
    return Center(child: CircularProgressIndicator());
  }
  else{
    return ListView.builder(
      reverse: true,
      itemCount: widget.mecanicos.length,
      itemBuilder: (context,index){
        return MecanicoCard(mecanico: widget.mecanicos[index],);
      });
  }
}

  Future<void> getMecanicos() async{
  try{
  Response response= await get("${kapiUrl}/mecanico");
  if(response.statusCode==400){
    Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error al obtener mecanicos')));
    
  }else{
    var jsonData= jsonDecode(response.body);
    List<Mecanico> mecanicos=[];
    for (var  mecJson in jsonData ) {
      Mecanico mecanico= Mecanico(id:mecJson["idMecanico"],nombre: "${mecJson["PersonaMecanico"]["nombres"]} ${mecJson["PersonaMecanico"]["apellidos"]}",direccion: mecJson["PersonaMecanico"]["direccion"],calificacion: mecJson["calificacion"],telefono: mecJson["PersonaMecanico"]["telefono"]);
      mecanicos.add(mecanico);
    }
    setState(() {
      widget.mecanicos= mecanicos;
    });
  }
  }catch(e){
     Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error al obtener mecanicos')));
    setState(() {
      widget.mecanicos=[];
    });
  }

}

}

