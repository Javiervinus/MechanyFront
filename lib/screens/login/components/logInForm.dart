import 'dart:convert';
import 'package:mechany/Constants.dart';
import 'package:mechany/components/formbutton.dart';
import 'package:mechany/components/forminput.dart';
import 'package:flutter/material.dart';
import 'package:mechany/screens/Register/register.dart';
import 'package:mechany/screens/home/home.dart';
import 'package:mechany/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../sizeConfig.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  @override
  LoginForm({Key key}) : super(key: key);
  _LoginFormState createState() => _LoginFormState();
}
// TODO: implement createState

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController contrasenaController = TextEditingController(text: "hola");
    TextEditingController usuarioController = TextEditingController(text: "vinus");

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
                    buildLabel("Contraseña:"),
                    FormInput(
                        controller: contrasenaController,
                        hintText: "Ingrese contrasena",
                        isContrasena: true),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20)),
                      child: DefaultButton(
                          text: "Iniciar Sesion",
                          press: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(usuarioController.text,
                                contrasenaController.text);

                            //aqui se conecta con api
                          }),
                    ),
                    DefaultButton(
                      text: "Registrarme",
                      press: () {
                        MaterialPageRoute ruta =
                            MaterialPageRoute(builder: (context) => Register());
                        Navigator.of(context).push(ruta);
                      },
                    )
                  ],
                )),
    );
  }

  signIn(String usuario, String contrasena) async {
    Map data = {'usuario': usuario, 'password': contrasena};
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try{
    var response = await http.post("${kapiUrl}/usuario/signin", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
        MaterialPageRoute ruta =
            MaterialPageRoute(builder: (context) => Home());
        Navigator.of(context).push(ruta);
      });
    } else {
      print("Usuario incorrecto");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error de autenticacion')));
      print(response.body);
      setState(() {
        _isLoading = false;
      });
    }
    }catch(e){
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error de conexion con el servidor')));
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
