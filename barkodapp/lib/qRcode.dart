import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  IconData icons = Icons.bookmark_add_outlined;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              color: Colors.blue.shade300,
              elevation: 12,
              child: ListTile(
                onTap: () => (result != null)
                    ? _launchURLApp()
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialog(context),
                      ),
                leading: Container(
                  color: Colors.amber,
                  child: IconButton(
                    icon: Icon(
                      icons,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (icons == Icons.bookmark_add_outlined) {
                            icons = Icons.bookmark_add_rounded;
                          } else {
                            icons = Icons.bookmark_add_outlined;
                          }

                          debugPrint("basılsdı");
                        },
                      );
                      if (result != null) {
                        true;
                      }
                    },
                  ),
                ),
                title: const Text("Bağlantıya gitmek için tıklayınız"),
                subtitle: (result != null)
                    ? Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    : const Text("No code "),
                trailing: const Icon(Icons.qr_code_scanner_sharp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  _launchURLApp() async {
    var url = Uri.parse(result!.code.toString()); //result!.code.toString()
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('HATA'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text("KOD YOK"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Çıkış'),
        ),
      ],
    );
  }
}
