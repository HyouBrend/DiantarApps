import 'package:diantar_jarak/bloc/serach_page/submit/submit_bloc.dart';
import 'package:diantar_jarak/bloc/serach_page/submit/submit_event.dart';
import 'package:diantar_jarak/bloc/serach_page/submit/submit_state.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/pages/result_page/result_page.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_customer.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_driver.dart';
import 'package:diantar_jarak/data/models/model_page_result/result_maps_model.dart';
import 'package:diantar_jarak/theme/size.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> customerDetails = [];
  final TextEditingController _driverController = TextEditingController();
  String? _driverPosition;

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(Sizes.dp16(context)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: Sizes.dp10(context)),
                Text(
                  "DATA SEDANG DALAM PROSES",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
        backgroundColor:
            CustomColorPalette.backgroundColor, // Warna background AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.history,
                color: CustomColorPalette.textColor), // Warna ikon AppBar
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListHistoryPage(),
                ),
              );
            },
          ),
          SizedBox(width: Sizes.dp4(context)), // SizedBox added here
        ],
      ),
      body: BlocProvider(
        create: (_) => SubmitBloc(),
        child: Padding(
          padding: EdgeInsets.all(Sizes.dp16(context)),
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
                          SizedBox(height: Sizes.dp12(context)),
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
                          SizedBox(height: Sizes.dp4(context)),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                customerDetails.add({});
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  CustomColorPalette.buttonTextColor,
                              backgroundColor: CustomColorPalette.buttonColor,
                            ),
                            child: const Icon(Icons.add),
                          ),
                          SizedBox(height: Sizes.dp10(context)),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (customerDetails.isNotEmpty) {
                                  customerDetails.removeLast();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  CustomColorPalette.buttonTextColor,
                              backgroundColor: CustomColorPalette.buttonColor,
                            ),
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
                            SizedBox(height: Sizes.dp4(context)),
                            ...customerDetails.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, String> details = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: Sizes.dp10(context)),
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
              SizedBox(height: Sizes.dp4(context)),
              BlocConsumer<SubmitBloc, SubmitState>(
                listener: (context, state) {
                  if (state is SubmitSuccess) {
                    Navigator.pop(context); // Close the loading dialog
                    List<MapsResultsModel> mapsResults =
                        customerDetails.map((details) {
                      return MapsResultsModel(
                        displayName: details['name'],
                        kontakID: details['kontakID'],
                        pointLatLong:
                            '${details['latitude']},${details['longitude']}',
                      );
                    }).toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          driverName: _driverController.text,
                          driverPosition: _driverPosition ?? 'Unknown',
                          customers: mapsResults,
                        ),
                      ),
                    );
                  } else if (state is SubmitInProgress) {
                    _showLoadingDialog(context);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<SubmitBloc>(context)
                              .add(SubmitButtonPressed());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: CustomColorPalette.buttonTextColor,
                          backgroundColor: CustomColorPalette.buttonColor,
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: Sizes.dp20(context)),
            ],
          ),
        ),
      ),
    );
  }
}
