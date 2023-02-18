import 'package:esc_printer_manager/esc_printer_manager.dart';
import 'package:intl/intl.dart';

List<int> printStyle(List<int> bytes, Generator generator) {
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

  bytes += generator.row([
    PosColumn(text: '', width: 1),
    PosColumn(text: '3X SUB ITEM 2', width: 11),
  ]);

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

  final String timestamp = DateFormat('MM/dd/yyyy H:m').format(DateTime.now());
  bytes += generator.text(timestamp,
      styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

  bytes += generator.reset();
  bytes += generator.cut();

  return bytes;
}
