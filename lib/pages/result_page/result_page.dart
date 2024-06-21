import 'package:diantar_jarak/bloc/maps/maps_event.dart';
import 'package:diantar_jarak/data/models/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/models/dropdown_drive_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:diantar_jarak/bloc/maps/maps_bloc.dart';
import 'package:diantar_jarak/bloc/maps/maps_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class ResultPage extends StatefulWidget {
  final String driverName;
  final String driverPosition;
  final List<Map<String, String>> customers;

  const ResultPage({
    super.key,
    required this.driverName,
    required this.driverPosition,
    required this.customers,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(-6.1819591, 106.7763663);
  List<LatLng> _polylinePoints = [];
  Set<Marker> _markers = {};

  final String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(LoadMapData());
  }

  void _initializeMarkersAndPolylines(List<DropdownDriveModel> drivers, List<DropdownCustomerModel> customers) async {
    _setMarkers(drivers, customers);
    await _setPolyline(customers);
  }

  void _setMarkers(List<DropdownDriveModel> drivers, List<DropdownCustomerModel> customers) {
    setState(() {
      _markers.clear();

      _markers.add(
        Marker(
          markerId: MarkerId('driver'),
          position: _center,
          infoWindow: InfoWindow(title: drivers.isNotEmpty ? drivers.first.nama : 'Driver', snippet: drivers.isNotEmpty ? drivers.first.posisi : 'Posisi'),
        ),
      );

      for (var customer in customers) {
        _markers.add(
          Marker(
            markerId: MarkerId(customer.displayName!),
            position: LatLng(
              double.parse(customer.latitude!),
              double.parse(customer.longitude!),
            ),
            infoWindow: InfoWindow(
              title: customer.displayName,
              snippet: customer.lokasi,
            ),
          ),
        );
      }
    });
  }

  Future<void> _setPolyline(List<DropdownCustomerModel> customers) async {
    List<LatLng> points = [];
    for (int i = 0; i < customers.length - 1; i++) {
      LatLng start = LatLng(
        double.parse(customers[i].latitude!),
        double.parse(customers[i].longitude!),
      );
      LatLng end = LatLng(
        double.parse(customers[i + 1].latitude!),
        double.parse(customers[i + 1].longitude!),
      );
      List<LatLng> polylinePoints = await _getPolylinePoints(start, end);
      points.addAll(polylinePoints);
    }

    setState(() {
      _polylinePoints = points;
    });
  }

  Future<List<LatLng>> _getPolylinePoints(LatLng start, LatLng end) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';
    Response response = await Dio().get(url);
    List<LatLng> points = [];
    if (response.data['status'] == 'OK') {
      var steps = response.data['routes'][0]['legs'][0]['steps'];
      for (var step in steps) {
        points.add(LatLng(step['start_location']['lat'], step['start_location']['lng']));
        points.add(LatLng(step['end_location']['lat'], step['end_location']['lng']));
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _initializeMarkersAndPolylines(state.drivers, state.customers);
            });
            return GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              markers: _markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: _polylinePoints,
                  color: Colors.red,
                  width: 5,
                )
              },
            );
          }
        },
      ),
    );
  }
}
