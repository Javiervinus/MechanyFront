import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Articulo.dart';
import 'package:mechany/components/formbutton.dart';
import 'package:mechany/screens/mecanicoDetails/components/ComentarioView.dart';
import 'package:mechany/screens/tiendaMenu/TiendaMenu.dart';
import 'package:mechany/sizeConfig.dart';

class ArticuloDetails extends StatefulWidget {
  final Articulo articulo;
  TextEditingController comentarioController = TextEditingController();
  ArticuloDetails({this.articulo});

  @override
  _ArticuloDetailsState createState() => _ArticuloDetailsState();
}

class _ArticuloDetailsState extends State<ArticuloDetails> {
  List<String> comentarios;

  @override
  void initState() {
    this.getComentarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [buildBackground(), buildContainer()],
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Image.asset("assets/img/accesorio_perfil.jpg");
  }

  Widget buildContainer() {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenHeight(230)),
      height: getProportionateScreenHeight(590),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(children: [
        Container(
            child: Text(
          widget.articulo.tienda.nombre,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(30),
              fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
            child: Text(
          widget.articulo.nombre,
          style: TextStyle(fontSize: getProportionateScreenHeight(25)),
        )),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        buildInfo(),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        buildComentariosSection(),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        createComentarioSection(),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        FlatButton(
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (_) => TiendaMenu(
                      tienda: widget.articulo.tienda,
                    ));
            Navigator.of(context).push(route);
          },
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Text("Ver tienda",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    color: kPrimaryLightColor)),
          ),
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        )
      ]),
    );
  }

  Widget buildInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildLabel(Icons.money_off, "\$${widget.articulo.costo}", Colors.green),
        SizedBox(
          width: getProportionateScreenWidth(80),
        ),
        buildLabel(
            Icons.star, "${widget.articulo.calificacion}", Colors.yellow[900])
      ],
    );
  }

  Widget buildLabel(IconData icono, String info, Color color) {
    return Row(children: [
      Icon(
        icono,
        size: getProportionateScreenHeight(30),
        color: color,
      ),
      SizedBox(
        width: getProportionateScreenWidth(10),
      ),
      Container(
          child: Text(
        info,
        style: TextStyle(fontSize: getProportionateScreenHeight(30)),
        overflow: TextOverflow.fade,
      ))
    ]);
  }

  Widget buildComentariosSection() {
    return Column(
      children: [
        Text(
          "Comentarios:",
          style: TextStyle(fontSize: getProportionateScreenHeight(25)),
        ),
        Container(
            height: getProportionateScreenHeight(150),
            width: getProportionateScreenWidth(300),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: buildListaComentarios()),
      ],
    );
  }

  Widget buildListaComentarios() {
    if (this.comentarios == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (this.comentarios.length == 0) {
        return Center(
            child: Text(
          "No existen comentarios",
        ));
      } else {
        return ListView.builder(
            itemCount: this.comentarios.length,
            itemBuilder: (context, index) {
              return ComentarioView(comentario: this.comentarios[index]);
            });
      }
    }
  }

  void getComentarios() async {
    try {
      Response response =
          await get("${kapiUrl}/comentarioa/${widget.articulo.codigoArticulo}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<String> comentarios = [];
        for (var jsonCom in jsonData) {
          comentarios.add(jsonCom["comentario"]);
        }
        setState(() {
          this.comentarios = comentarios;
        });
      } else {
        setState(() {
          this.comentarios = [];
        });
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Error al obtener comentarios')));
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener comentarios')));
    }
  }

  Widget createComentarioSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: widget.comentarioController,
            obscureText: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              hintText: "Ingrese comentario",
              fillColor: kPrimaryLightColor,
              filled: true,
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(40),
        ),
        DefaultButton(
          text: "Ingresar comentario",
          press: () {
            createComentario();
          },
        )
      ],
    );
  }

  void createComentario() async {
    Map data = {
      'idArticulo': widget.articulo.codigoArticulo,
      'comentario': widget.comentarioController.text
    };
    try {
      Response response = await post("${kapiUrl}/comentarioa", body: data);
      if (response.statusCode == 200) {
        this.getComentarios();
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Error al crear comentario')));
      }
    } catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error al crear comentario')));
    }
  }
}
