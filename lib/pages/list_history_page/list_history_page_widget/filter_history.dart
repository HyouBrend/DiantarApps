import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/theme/theme.dart'; // Import your CustomColorPalette
import 'package:flutter/material.dart';

class FilterHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              DropdownWidget(
                items: ['Option 1', 'Option 2', 'Option 3'],
              ),
              SizedBox(width: Sizes.dp1(context)),
              DropdownWidget(
                items: ['Option A', 'Option B', 'Option C'],
              ),
              SizedBox(width: Sizes.dp1(context)),
              DropdownWidget(
                items: ['Option X', 'Option Y', 'Option Z'],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  final List<String> items;

  DropdownWidget({required this.items});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColorPalette.surfaceColor, 
        border: Border.all(color: Colors.grey, width: 1), 
        borderRadius: BorderRadius.circular(4), 
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text('Select'),
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
        ),
      ),
    );
  }
}
