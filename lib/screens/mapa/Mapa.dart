import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Tienda.dart';

class MapaPage extends StatefulWidget {
  final Tienda tienda;
  MapaPage({this.tienda});
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  String _mapStyle;
  GoogleMapController mapController;
  Location _locationTracker = Location();
  StreamSubscription _locationSubscription;
  Set<Marker> markers = {};
  Marker marker;
  Polyline polyline;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyAmhyw0Zl5Y0NGx8dRbPpqUzE0IZKwf7Y4");
  LatLng coordenadasTienda;

  @override
  void initState() {
    coordenadasTienda = LatLng(widget.tienda.latitud, widget.tienda.longitud);

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    super.initState();
  }

  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(-2.152582, -79.865572), zoom: 12);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
        markers: markers,
        polylines: Set.of((polyline != null) ? [polyline] : []),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);

    markers.addAll([
      Marker(
        markerId: MarkerId("tienda"),
        position: coordenadasTienda,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
      ),
    ]);
    setState(() {
      getCurrentLocation();
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);
      await getRuta(location, coordenadasTienda);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/img/icons8-car-48.png");
    return byteData.buffer.asUint8List();
  }

  Future<void> getRuta(LocationData ubicacion, LatLng destino) async {
    List<LatLng> puntos = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(ubicacion.latitude, ubicacion.longitude),
        destination: destino,
        mode: RouteMode.driving);
    setState(() {
      polyline = Polyline(
          polylineId: PolylineId('RutaSucursal'),
          color: kPrimaryColor,
          points: puntos,
          visible: true,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          width: 4);
    });
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      markers.remove(marker);
      marker = Marker(
          markerId: MarkerId("Usuario"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      markers.add(marker);
    });
  }
}
