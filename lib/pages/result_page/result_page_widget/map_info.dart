import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final List<Map<String, String>> customers;

  const MapWidget({
    super.key,
    required this.customers,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(-6.200000, 106.816666),
        zoom: 10,
      ),
      markers: customers.map((customer) {
        return Marker(
          markerId: MarkerId(customer['name'] ?? ''),
          position: LatLng(
            double.parse(customer['latitude'] ?? '0'),
            double.parse(customer['longitude'] ?? '0'),
          ),
          infoWindow: InfoWindow(title: customer['name']),
        );
      }).toSet(),
    );
  }
}
