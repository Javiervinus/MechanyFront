class PersonaUsuario {
  String usuario;
  String password;

  PersonaUsuario({this.usuario, this.password});
  factory PersonaUsuario.fromJson(Map<String, dynamic> parsedJson) {
    return PersonaUsuario(
        usuario: parsedJson["usuario"], password: parsedJson["password"]);
  }
}
