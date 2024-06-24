import 'package:diantar_jarak/pages/search_page/search_page.dart';
import 'package:flutter/material.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SearchPage(),
          ),
        ],
      ),
    );
  }
}
