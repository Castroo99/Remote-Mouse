import 'package:flutter/material.dart';
import 'tcp_client.dart';

class HomePage extends StatelessWidget {
  final TcpClient client;
  const HomePage({super.key, required this.client});

  void _sendMouseMove() {
    client.send({"action": "mouse_move", "dx": 50, "dy": 0});
  }

  void _sendClick() {
    client.send({"action": "mouse_click"});
  }

  void _sendTypeText() {
    client.send({"action": "type", "text": "ciao dal telefono"});
  }

  void _sendVolumeUp() {
    client.send({"action": "volume", "delta": 0.05});
  }

  void _sendVolumeDown() {
    client.send({"action": "volume", "delta": -0.05});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Controllo Remoto")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _sendMouseMove, child: const Text("Muovi Mouse ➡️")),
            ElevatedButton(
                onPressed: _sendClick, child: const Text("Click Sinistro")),
            ElevatedButton(
                onPressed: _sendTypeText,
                child: const Text("Scrivi 'ciao dal telefono'")),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _sendVolumeDown,
                    child: const Text("🔉 Volume -")),
                ElevatedButton(
                    onPressed: _sendVolumeUp, child: const Text("🔊 Volume +")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
