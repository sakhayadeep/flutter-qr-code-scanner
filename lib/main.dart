import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: (scanResult == null)?Text("Press SCAN to get result"):Text(scanResult),
            ),
            RaisedButton(
              onPressed: () => _onQrCodeScannerButtonPressed(),
              child: Text("SCAN"),
            ),
          ],
        ),
      ),
    );
  }
}
