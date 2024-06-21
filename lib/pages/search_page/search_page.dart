import 'package:diantar_jarak/pages/result_page/result_page.dart';
import 'package:diantar_jarak/pages/search_page/dropdown_widget/dropdown_customer.dart';
import 'package:diantar_jarak/pages/search_page/dropdown_widget/dropdown_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/maps/maps_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> customerDetails = [];
  final TextEditingController _driverController = TextEditingController();
  String? _driverPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diantar Jarak',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        DropdownDriver(
                          controller: _driverController,
                          onPositionSelected: (position) {
                            _driverPosition = position;
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              customerDetails.add({});
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (customerDetails.isNotEmpty) {
                                customerDetails.removeLast();
                              }
                            });
                          },
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          ...customerDetails.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, String> details = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: DropdownCustomer(
                                onDetailsEntered: (newDetails) {
                                  setState(() {
                                    customerDetails[index] = newDetails;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: context.read<MapBloc>(),
                      child: ResultPage(
                        driverName: _driverController.text,
                        driverPosition: _driverPosition ?? 'Unknown',
                        customers: customerDetails,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
