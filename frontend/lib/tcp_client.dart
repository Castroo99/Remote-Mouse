import 'dart:convert';
import 'dart:io';

class TcpClient {
  Socket? _socket;
  final String host;
  final int port;

  TcpClient({required this.host, required this.port});

  Future<void> connect() async {
    _socket = await Socket.connect(host, port);
    print('✅ Connesso a $host:$port');
  }

  void send(Map<String, dynamic> message) {
    if (_socket != null) {
      final jsonStr = jsonEncode(message);
      _socket!.write(jsonStr);
    } else {
      print('⚠️ Socket non connesso');
    }
  }

  void disconnect() {
    _socket?.close();
  }
}
