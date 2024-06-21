import 'package:flutter/material.dart';

class CustomerInfo extends StatelessWidget {
  final List<Map<String, String>> customers;

  const CustomerInfo({
    super.key,
    required this.customers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...customers.map((customer) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${customer['name'] ?? ''}'),
                Text('Type: ${customer['type'] ?? ''}'),
                Text('Location: ${customer['location'] ?? ''}'),
                Text('Latitude: ${customer['latitude'] ?? ''}'),
                Text('Longitude: ${customer['longitude'] ?? ''}'),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
