import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchFooterWidget extends StatelessWidget {
  const SearchFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar saat ini
    double screenWidth = MediaQuery.of(context).size.width;

    // Jika lebar layar kurang dari 600px, anggap ini sebagai mode mobile
    bool isMobile = screenWidth < 600;

    return Container(
      width: double.infinity, // Membuat lebar 100% sesuai halaman
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.grey[850],
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center, // Mengatur teks copyright di tengah
            child: Text(
              'Copyright © Seintech. All rights reserved',
              style: TextStyle(
                fontSize:
                    isMobile ? 10 : 14, // Ukuran font lebih kecil di mobile
                fontWeight: isMobile
                    ? FontWeight.w300
                    : FontWeight.normal, // Lebih ringan di mobile
                color: CustomColorPalette.surfaceColor,
              ),
            ),
          ),
          Align(
            alignment:
                Alignment.centerRight, // Mengatur teks versi di sebelah kanan
            child: Text(
              'Version v.1.1.1',
              style: TextStyle(
                fontSize:
                    isMobile ? 10 : 14, // Ukuran font lebih kecil di mobile
                fontWeight: isMobile
                    ? FontWeight.w300
                    : FontWeight.normal, // Lebih ringan di mobile
                color: CustomColorPalette.surfaceColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
