import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR CODE SCANNER',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'QR CODE SCANNER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String scanResult;

  @override
  initState(){
    super.initState();
    _onBarCodeScannerButtonPressed();
  }

  _onQrCodeScannerButtonPressed() async {
    String qrCodeData = await QRCodeReader()
               .setAutoFocusIntervalInMs(200)
               .setForceAutoFocus(true)
               .setTorchEnabled(true)
               .setHandlePermissions(true)
               .setExecuteAfterPermissionGranted(true)
               .scan();
    setState(() {
      scanResult = qrCodeData;
    });
  }

  _onBarCodeScannerButtonPressed() async {
    String barCodeData = await FlutterBarcodeScanner.scanBarcode("#008080","",false);
    setState(() {
      scanResult = barCodeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: (scanResult == null)?Text("Press SCAN to get result"):Text(scanResult),
            ),
            Row(
              children:[
                Expanded(child: FlatButton(color: Colors.teal,onPressed: () => _onQrCodeScannerButtonPressed(),child: Text("QR CODE SCAN"),),),
                Expanded(child: FlatButton(color: Colors.teal,onPressed: () => _onBarCodeScannerButtonPressed(),child: Text("BARCODE SCAN"),),)
              ]
            ),
          ],
        ),
      ),
    );
  }
}
