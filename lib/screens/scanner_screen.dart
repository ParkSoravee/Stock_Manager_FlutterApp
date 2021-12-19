// import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  final Function setValueFn;
  final bool isQr;
  const ScannerScreen({
    required this.setValueFn,
    this.isQr = false,
    Key? key,
  }) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // for hot reload
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildQrView(context),
            Positioned(
              child: Text(
                widget.isQr
                    ? 'ให้ตำแหน่ง QR Code อยู่กลางภาพ'
                    : 'ให้ตำแหน่ง Barcode อยู่กลางภาพ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              bottom: MediaQuery.of(context).size.height / 6,
            ),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.transparent,
                height: 60,
                width: MediaQuery.of(context).size.width - 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(6),
                        primary: Colors.grey.withOpacity(0.3),
                        elevation: 0,
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                        size: 30,
                        // color: Colors.transparent,
                      ),
                    ),
                    Text(
                      'แสกนสินค้า',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(6),
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Icon(
                        Icons.flash_off,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        // cutOutSize: MediaQuery.of(context).size.width * 0.8,
        cutOutHeight: widget.isQr
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width * 0.8 * 0.4,
        cutOutWidth: MediaQuery.of(context).size.width * 0.8,
        // cutOutWidth: ,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      result = scanData;
      if (widget.isQr == true &&
          result!.format == BarcodeFormat.qrcode &&
          result!.code!.length >= 38) {
        widget.setValueFn(context, scanData.code!);
        controller.stopCamera();
        controller.dispose();
        Navigator.pop(context);
      }
      if (result!.code!.length == 13 &&
          result!.format == BarcodeFormat.code128) {
        widget.setValueFn(context, scanData.code!);
        controller.stopCamera();
        controller.dispose();
        Navigator.pop(context);
      }
      // });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
