import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mechany/Model/Persona.dart' as Per;
import 'package:mechany/Model/PersonaUsuario.dart';
import 'package:mechany/components/formbutton.dart';
import 'package:mechany/components/forminput.dart';
import 'package:flutter/material.dart';
import 'package:mechany/screens/home/home.dart';
import 'package:mechany/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants.dart';
import '../../../model/PersonaUsuario.dart';
import '../../../model/Persona.dart';
import '../../../sizeConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterForm extends StatefulWidget {
  @override
  RegisterForm({Key key}) : super(key: key);
  _RegisterFormState createState() => _RegisterFormState();
}
// TODO: implement createState

class _RegisterFormState extends State<RegisterForm> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController contrasenaController = TextEditingController();
    TextEditingController usuarioController = TextEditingController();
    TextEditingController nombreController = TextEditingController();
    TextEditingController correoController = TextEditingController();
    TextEditingController direccionController = TextEditingController();
    TextEditingController apellidoController = TextEditingController();
    TextEditingController telefonoController = TextEditingController();

    return Center(
      child: Form(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel("Usuario:"),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20)),
                      child: FormInput(
                          controller: usuarioController,
                          hintText: "Ingrese Usuario",
                          isContrasena: false),
                    ),
                    buildLabel("Nombre:"),
                    FormInput(
                        controller: nombreController,
                        hintText: "Ingrese nombre",
                        isContrasena: false),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildLabel("Apellido:"),
                    FormInput(
                        controller: apellidoController,
                        hintText: "Ingrese apellido",
                        isContrasena: false),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    buildLabel("Correo:"),
                    FormInput(
                        controller: correoController,
                        hintText: "Ingrese correo",
                        isContrasena: false),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildLabel("telefono:"),
                    FormInput(
                        controller: telefonoController,
                        hintText: "Ingrese telefono",
                        isContrasena: false),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    buildLabel("Direccion:"),
                    FormInput(
                        controller: direccionController,
                        hintText: "Ingrese direccion",
                        isContrasena: false),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildLabel("Contraseña:"),
                    FormInput(
                        controller: contrasenaController,
                        hintText: "Ingrese contrasena",
                        isContrasena: true),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20)),
                      child: DefaultButton(
                          text: "Registrarme",
                          press: () {
                            signUp(
                                usuarioController.text,
                                contrasenaController.text,
                                correoController.text,
                                nombreController.text,
                                telefonoController.text,
                                direccionController.text,
                                apellidoController.text);

                            //aqui se conecta con api
                          }),
                    ),
                  ],
                )),
    );
  }

  signUp(String usuario, String contrasena, String nombre, String correo,
      String apellido, String telefono, String direccion) async {
    String jsonString = '{"nombres": "' +
        nombre +
        '", "apellidos": "' +
        apellido +
        '", "telefono": "' +
        telefono +
        '", "correo": "' +
        correo +
        '", "direccion": "' +
        direccion +
        '", "PersonaUsuario": {"usuario": "' +
        usuario +
        '", "password": "' +
        contrasena +
        '"}}';
    var json2 = jsonEncode(jsonString);
    // Map<String, dynamic> superMap = {
    //   "nombres": usuario,
    //   "apellidos": apellido,
    //   "telefono": telefono,
    //   "correo": correo,
    //   "direccion": direccion
    // };
    // superMap["PersonaUsuario"] = new Map();
    // var maps = {"usuario": usuario, "password": contrasena};
    // superMap["PersonaUsuario"].addAll(maps);
    // print(superMap);
    var jsonData = null;
    Map<String, String> headers2 = {"Content-Type": "application/json"};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response =
        await http.post("${kapiUrl}/usuario", body: json2, headers: headers2);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print(response.body);
      setState(() {
        _isLoading = false;

        Navigator.of(context).pop();
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Usuario ya registrado')));
    }
  }

  Padding buildLabel(String texto) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(7),
          horizontal: getProportionateScreenWidth(20)),
      child: Text(
        texto,
        style: TextStyle(fontSize: getProportionateScreenHeight(25)),
      ),
    );
  }
}
