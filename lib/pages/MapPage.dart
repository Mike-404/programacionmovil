import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  final String? altitud;
  final String? longitud;

  MapaPage({required this.altitud, required this.longitud});

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  late LatLng initialPosition;

  @override
  void initState() {
    super.initState();
    initialPosition = LatLng(double.parse(widget.altitud!), double.parse(widget.longitud!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 15,
        ),
      ),
    );
  }
}