import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  String? _selectedFilter;
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  void _onFilterChanged(String? newValue) {
    setState(() {
      _selectedFilter = newValue;
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onSearch() {
    setState(() {
      _isLoading = true;
    });

    // Simulate a search operation with a delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        // Implement your search logic here
        // Example: Perform a search with _searchController.text
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: CustomColorPalette
          .backgroundColor, // Corrected property for background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search history...',
              hintStyle: TextStyle(color: CustomColorPalette.hintTextColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _isLoading ? null : _onSearch,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Filter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            width: 200, // Adjust the width as needed
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: _selectedFilter,
              hint: Text('Select filter'),
              isExpanded: true,
              underline: SizedBox(), // Remove the default underline
              items: ['Filter 1', 'Filter 2', 'Filter 3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: _onFilterChanged,
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
