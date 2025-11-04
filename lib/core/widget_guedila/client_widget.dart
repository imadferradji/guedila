import 'package:flutter/material.dart';

class ClientWidget extends StatelessWidget {
  final List<Client> clients;

  const ClientWidget({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ...clients.asMap().entries.map((entry) =>
              _buildClientRow(entry.value, entry.key)
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildClientRow(Client client, int index) {
    final bool isEvenRow = index % 2 == 0;
    final Color backgroundColor = isEvenRow ? Colors.lightBlue[50]! : Colors.white;

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                client.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                client.number.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Client {
  final String name;
  final int number;

  const Client({required this.name, required this.number});
}

// Alternative simple version with map
class SimpleClientWidget extends StatelessWidget {
  final Map<String, int> clients;

  const SimpleClientWidget({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ...clients.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final clientEntry = entry.value;
            final bool isEvenRow = index % 2 == 0;
            final Color backgroundColor = isEvenRow ? Colors.lightBlue[50]! : Colors.white;
            return Container(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      clientEntry.key,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      clientEntry.value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Usage example:
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = [
      Client(name: 'Client 1', number: 80),
      Client(name: 'Client 2', number: 120),
      Client(name: 'Client 3', number: 60),
      Client(name: 'Client 4', number: 45),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: ClientWidget(clients: clients),
    );
  }
}