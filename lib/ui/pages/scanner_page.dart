import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:untitled5_clase9/ui/general/colors.dart';
import 'package:untitled5_clase9/ui/pages/register_page.dart';
import 'package:untitled5_clase9/ui/widgets/button_normal_widget.dart';
import 'package:untitled5_clase9/ui/widgets/general_widget.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isURL = false;
  String valueURL = "";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: KBrandPrimaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if(result !=null){
          valueURL = result!.code!;
          isURL = checkURL(valueURL);
          print("QQQQQQQQQQQQQQQQQQQQQQQQQQ ${isURL}");
        }
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {

    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
  bool checkURL(String value){
    bool res = value.contains("http");
    return res;
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
      ),*/
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: KBrandSecundaryColor,
                //borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight:Radius.circular(32) )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( isURL ? valueURL : "Por favor, escanea un código QR.",
                //"https://www.youtube.com/watch?v=XQ45gynAUPg&ab_channel=AbbaVEVO https://www.youtube.com/watch?v=XQ45gynAUPg&ab_channel=AbbaVEVO",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,),),
                  divider10,
                  ButtonNormalWidget(text: "Registrar QR", onPressed: !isURL ?
                   (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(valueQr: "https://github.com/juliuscanute/qr_code_scanner/issues/560"),));
                   } : null)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
