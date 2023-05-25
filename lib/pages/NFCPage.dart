import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NFCPage extends StatefulWidget {
  @override
  _NFCPageState createState() => _NFCPageState();
}

class _NFCPageState extends State<NFCPage> {
  bool _isNFCSupported = false;
  bool _isNFCAvailable = false;
  StreamSubscription<NFCTag> _nfcTagSubscription;

  @override
  void initState() {
    super.initState();
    _checkNFCStatus();
  }

  @override
  void dispose() {
    _nfcTagSubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkNFCStatus() async {
    bool isSupported = await FlutterNfcKit.nfcIsSupported;
    bool isAvailable = await FlutterNfcKit.nfcAvailability;

    setState(() {
      _isNFCSupported = isSupported;
      _isNFCAvailable = isAvailable;
    });

    if (isSupported && isAvailable) {
      _startNFCListening();
    }
  }

  Future<void> _startNFCListening() async {
    try {
      _nfcTagSubscription = FlutterNfcKit.nfcStartListen().listen((NFCTag tag) {
        // Handle the NFC tag data
        // You can read the tag information and perform desired operations
      });
    } catch (e) {
      print('Error listening to NFC: $e');
    }
  }

  void _stopNFCListening() {
    _nfcTagSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('NFC Supported: $_isNFCSupported'),
            Text('NFC Available: $_isNFCAvailable'),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('Start NFC Listening'),
              onPressed: _startNFCListening,
            ),
            RaisedButton(
              child: Text('Stop NFC Listening'),
              onPressed: _stopNFCListening,
            ),
          ],
        ),
      ),
    );
  }
}

