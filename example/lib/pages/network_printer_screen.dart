import 'package:esc_printer_manager/esc_printer_manager.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class NetWorkPrinterScreen extends StatefulWidget {
  @override
  _NetWorkPrinterScreenState createState() => _NetWorkPrinterScreenState();
}

class _NetWorkPrinterScreenState extends State<NetWorkPrinterScreen> {
  bool _isLoading = false;
  List<NetworkPrinter> _printers = [];
  NetworkPrinterManager? _manager;

  String _name = "default";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Printer Screen ${printProfiles.length}"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => printProfiles
                .map(
                  (e) => PopupMenuItem(
                    enabled: e["key"] != _name,
                    child: Text("${e["key"]}"),
                    onTap: () {
                      setState(() {
                        _name = e["key"];
                      });
                    },
                  ),
                )
                .toList(),
          )
        ],
      ),
      body: ListView(
        children: [
          ..._printers
              .map((printer) => ListTile(
                    title: Text("${printer.name}"),
                    subtitle: Text("${printer.address}"),
                    leading: const Icon(Icons.cable),
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
        onPressed: _isLoading ? null : _scan,
        child:
            _isLoading ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
      ),
    );
  }

  _scan() async {
    setState(() {
      _isLoading = true;
      _printers = [];
    });
    var printers = await NetworkPrinterManager.discover();
    setState(() {
      _isLoading = false;
      _printers = printers;
    });
  }

  _connect(NetworkPrinter printer) async {
    var paperSize = PaperSize.mm80;
    var profile = await CapabilityProfile.load();
    var manager = NetworkPrinterManager(printer, paperSize, profile);
    await manager.connect();
    setState(() {
      _manager = manager;
      printer.connected = true;
    });
  }

  _startPrinter() async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += printStyle(bytes, generator);

    if (_manager != null) {
      debugPrint("isConnected ${_manager!.isConnected}");
      await _manager!.writeBytes(bytes, isDisconnect: true);
    }
  }
}
