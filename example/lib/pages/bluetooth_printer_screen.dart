import 'package:esc_printer_manager/models/bluetooth_printer.dart';
import 'package:esc_printer_manager/services/bluetooth_printer_manager.dart';
import 'package:flutter/material.dart';

import '../service.dart';

class BluetoothPrinterScreen extends StatefulWidget {
  @override
  _BluetoothPrinterScreenState createState() => _BluetoothPrinterScreenState();
}

class _BluetoothPrinterScreenState extends State<BluetoothPrinterScreen> {
  bool _isLoading = false;
  List<BluetoothPrinter> _printers = [];
  BluetoothPrinterManager? _manager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Printer Screen"),
      ),
      body: ListView(
        children: [
          ..._printers
              .map((printer) => ListTile(
                    title: Text("${printer.name}"),
                    subtitle: Text("${printer.address}"),
                    leading: Icon(Icons.bluetooth),
                    onTap: () => _connect(printer),
                    onLongPress: () {
                      _startPrinter();
                    },
                    selected: printer.connected,
                  ))
              .toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: _isLoading ? Icon(Icons.stop) : Icon(Icons.play_arrow),
        onPressed: _isLoading ? null : _scan,
      ),
    );
  }

  _scan() async {
    print("scan");
    setState(() {
      _isLoading = true;
      _printers = [];
    });
    var printers = await BluetoothPrinterManager.discover();
    print(printers);
    setState(() {
      _isLoading = false;
      _printers = printers;
    });
  }

  _connect(BluetoothPrinter printer) async {
    var paperSize = PaperSize.mm80;
    var profile = await CapabilityProfile.load();
    var manager = BluetoothPrinterManager(printer, paperSize, profile);
    await manager.connect();
    print(" -==== connected =====- ");
    setState(() {
      _manager = manager;
      printer.connected = true;
    });
  }

  _startPrinter() async {
    final content = Demo.getShortReceiptContent();
    var bytes = await WebcontentConverter.contentToImage(content: content);
    var service = ESCPrinterService(bytes);
    var data = await service.getBytes(paperSize: PaperSize.mm58);
    if (_manager != null) {
      print("isConnected ${_manager!.isConnected}");
      _manager!.writeBytes(data, isDisconnect: false);
    }
  }


  List<int> printStyle2(List<int> bytes, Generator generator) {
    bytes += generator.setGlobalCodeTable('CP1252');

    bytes += generator.text('Receipt',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(text: 'Item', width: 6),
      PosColumn(
          text: 'Price',
          width: 3,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Total',
          width: 3,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.row([
      PosColumn(text: '1X ITEM 1', width: 6),
      PosColumn(
          text: '88.00',
          width: 3,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '88.00',
          width: 3,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.row([
      PosColumn(text: '', width: 1),
      PosColumn(text: '2X SUB ITEM 1', width: 11),
    ]);

    // bytes += generator.row([
    //   PosColumn(text: '', width: 1),
    //   PosColumn(text: '3X SUB ITEM 2', width: 11),
    // ]);

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: const PosStyles(
            bold: true,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )),
      PosColumn(
          text: "\$ 100.00",
          width: 6,
          styles: const PosStyles(
            bold: true,
            align: PosAlign.right,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )),
    ]);

    bytes += generator.hr(ch: '=', linesAfter: 1);

    bytes += generator.text('Thank you!',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    final String timestamp =
    DateFormat('MM/dd/yyyy H:m').format(DateTime.now());
    bytes += generator.text(timestamp,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.cut();

    return bytes;
  }

}
