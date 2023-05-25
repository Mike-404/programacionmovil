import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoordenadasPage extends StatefulWidget {
  @override
  _CoordenadasPageState createState() => _CoordenadasPageState();
}

class _CoordenadasPageState extends State<CoordenadasPage> {
  String? altitud;
  String? longitud;

  Future<void> obtenerCoordenadas() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      altitud = position.altitude.toString();
      longitud = position.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: obtenerCoordenadas,
              child: Text('Obtener Coordenadas'),
            ),
            SizedBox(height: 20),
            Text('Altitud: $altitud'),
            Text('Longitud: $longitud'),
          ],
        ),
      ),
    );
  }
}