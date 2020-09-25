import 'package:mechany/Model/Tienda.dart';

class Articulo {
  String codigoArticulo;
  String nombre;
  String marca;
  String descripcion;
  num costo;
  num cantidad;
  num calificacion;
  Tienda tienda;

  Articulo({this.codigoArticulo,this.nombre,this.marca,this.descripcion,this.costo,this.cantidad,this.calificacion,this.tienda});
}