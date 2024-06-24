import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_result/result_maps_model.dart';
import 'package:diantar_jarak/theme/size.dart';

class ResultPage extends StatelessWidget {
  final String driverName;
  final String driverPosition;
  final List<MapsResultsModel> customers;

  const ResultPage({
    Key? key,
    required this.driverName,
    required this.driverPosition,
    required this.customers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dp16(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Driver: $driverName'),
            Text('Position: $driverPosition'),
            SizedBox(height: Sizes.dp20(context)),
            Text('Customers:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return ListTile(
                    title: Text(customer.displayName ?? 'Unknown'),
                    subtitle: Center(
                      child: Text(
                        customer.pointLatLong ?? 'No coordinates',
                        style: TextStyle(fontSize: Sizes.dp4(context)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
