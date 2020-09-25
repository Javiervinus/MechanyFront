import 'package:mechany/Model/PersonaUsuario.dart';

class Persona {
  String nombres;
  String apellidos;
  String telefono;
  String correo;
  String direccion;
  PersonaUsuario personaUsuario;

  Persona(
      {this.nombres,
      this.apellidos,
      this.telefono,
      this.correo,
      this.direccion,
      this.personaUsuario});
  factory Persona.fromJson(Map<String, dynamic> parsedJson) {
    return Persona(
        nombres: parsedJson["nombres"],
        apellidos: parsedJson["apellidos"],
        telefono: parsedJson["telefono"],
        correo: parsedJson["correo"],
        direccion: parsedJson["direccion"],
        personaUsuario: PersonaUsuario.fromJson(parsedJson["PersonaUsuario"]));
  }
}
