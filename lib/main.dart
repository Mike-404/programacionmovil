import 'package:flutter/material.dart';
import 'package:primeraemulacion/pages/CalculatorScreen.dart';
import 'package:primeraemulacion/pages/CalendarioPage.dart';
import 'package:primeraemulacion/pages/ContadorImg.dart';
import 'package:primeraemulacion/pages/CoordenadasPage.dart';
import 'package:primeraemulacion/pages/LoginPage.dart';
import 'package:primeraemulacion/pages/MapPage.dart';
import 'package:primeraemulacion/pages/NFCPage.dart';
import 'package:primeraemulacion/pages/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  String nombreUsuario = '';

  void onLogin(String username) {
    setState(() {
      nombreUsuario = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      WelcomePage(nombreUsuario: nombreUsuario),
      LoginPage(onLogin: onLogin),
      CoordenadasPage(),
      MapaPage(altitud: '0', longitud: '0',),
      CalculatorScreen(),
      ContadorImg(),
      CalendarioPage(),
      NFCPage(),

    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Iniciar Sesión',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Coordenadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), // Icono del ítem
            label: 'Contador', // Etiqueta del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nfc),
            label: 'NFC',
          ),
        ],
      ),
    );
  }
}