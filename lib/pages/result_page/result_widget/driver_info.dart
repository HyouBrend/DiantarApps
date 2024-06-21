import 'package:flutter/material.dart';

class DriverInfo extends StatelessWidget {
  final String driverName;
  final String driverPosition;

  const DriverInfo({
    super.key,
    required this.driverName,
    required this.driverPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Driver Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text('Name: $driverName'),
        Text('Position: $driverPosition'),
      ],
    );
  }
}
