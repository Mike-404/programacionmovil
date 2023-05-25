import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String nombreUsuario;

  WelcomePage({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'URL_IMAGEN_BIENVENIDA',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Bienvenido',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre: $nombreUsuario',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
