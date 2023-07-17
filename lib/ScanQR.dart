// ignore_for_file: prefer_const_constructors

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// callScanner() async {
//   String codeSanner = await BarcodeScanner.scan();
// }

Future scanCode() async {
  String barcodeScanRes;

  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", "Cancel", true, ScanMode.QR);
  return barcodeScanRes;
}
