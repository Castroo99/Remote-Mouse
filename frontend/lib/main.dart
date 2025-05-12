import 'package:flutter/material.dart';
import 'tcp_client.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = TcpClient(
      host: '192.168.1.10', port: 5050); // 🔁 Cambia con IP reale del tuo PC
  await client.connect();

  runApp(RemoteMouse(client: client));
}

class RemoteMouse extends StatelessWidget {
  final TcpClient client;
  const RemoteMouse({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controllo Remoto',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(client: client),
    );
  }
}
