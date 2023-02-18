import '../enums/connection_type.dart';
import 'pos_printer.dart';

class NetworkPrinter extends POSPrinter {
  NetworkPrinter({
    String? id,
    String? name,
    String? address,
    bool connected = false,
    int type = 0,
    ConnectionType? connectionType,
  }) {
    this.id = id;
    this.name = name;
    this.address = address;
    this.connected = connected;
    this.type = type;
    this.connectionType = ConnectionType.network;
  }
}
