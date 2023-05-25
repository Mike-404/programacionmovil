
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContadorImg extends StatefulWidget {
  @override
  _ContadorImgState createState() => _ContadorImgState();
}

class _ContadorImgState extends State<ContadorImg> {
  int contador = 0;

  // Referencia a la colección "numeros" en Firestore
  CollectionReference numerosCollection =
  FirebaseFirestore.instance.collection('Numeros');

  // Método para incrementar el contador y actualizar el valor en Firestore
  Future<void> incrementarContador() async {
    contador++;

    // Actualizar el valor del contador en Firestore
    await numerosCollection.doc('1').update({'valor': contador});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Contador'),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contador:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              contador.toString(),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: incrementarContador,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 20),
            StreamBuilder<DocumentSnapshot>(
              stream: numerosCollection.doc('1').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int imagenValor = snapshot.data!['valor'];

                  return Image.network(
                    snapshot.data!['imagenURL'],
                    width: 200,
                    height: 200,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
