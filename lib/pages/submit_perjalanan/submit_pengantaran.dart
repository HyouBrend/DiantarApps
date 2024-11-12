import 'package:diantar_jarak/pages/search_dropdown/search_dropdown.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmitResultPage extends StatelessWidget {
  final SubmitPerjalananModel submitPengantaranModel;

  const SubmitResultPage({
    super.key,
    required this.submitPengantaranModel,
  });

  // Fungsi buildRow yang responsif
  Widget buildRow(String label, String? value, BuildContext context) {
    double getLabelWidth(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1024) {
        return 200; // Lebar kolom label untuk desktop
      } else if (screenWidth > 768 && screenWidth <= 1024) {
        return 150; // Lebar kolom label untuk tablet
      } else {
        return 120; // Lebar kolom label lebih kecil untuk mobile
      }
    }

    double getFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1024) {
        return 18; // Ukuran font lebih besar untuk desktop
      } else if (screenWidth > 768 && screenWidth <= 1024) {
        return 16; // Ukuran font sedang untuk tablet
      } else {
        return 14; // Ukuran font lebih kecil untuk mobile
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: getLabelWidth(context), // Lebar kolom label responsif
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context), // Ukuran font responsif
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            ":",
            style: TextStyle(
              fontSize: getFontSize(context), // Ukuran font responsif
              color: CustomColorPalette.textColor,
            ),
          ),
          const SizedBox(width: 8), // Space antara label dan value
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              value ?? '',
              style: TextStyle(
                fontSize: getFontSize(context), // Ukuran font responsif
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getResponsiveMargin(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1024) {
      return 200; // Margin lebih besar untuk desktop
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      return 150; // Margin menengah untuk tablet
    } else {
      return 30; // Margin lebih kecil untuk mobile
    }
  }

  double getFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1024) {
      return baseSize; // Ukuran font untuk desktop tetap
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      return baseSize - 2; // Ukuran font lebih kecil untuk tablet
    } else {
      return baseSize - 4; // Ukuran font lebih kecil untuk mobile
    }
  }

  double getLabelWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1024) {
      return 200; // Lebar kolom label untuk desktop
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      return 150; // Lebar kolom label untuk tablet
    } else {
      return 120; // Lebar kolom label lebih kecil untuk mobile
    }
  }

  double getIconSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1024) {
      return baseSize; // Ukuran ikon untuk desktop tetap
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      return baseSize - 5; // Ukuran ikon lebih kecil untuk tablet
    } else {
      return baseSize - 10; // Ukuran ikon lebih kecil untuk mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    double marginSize =
        _getResponsiveMargin(context); // Mendapatkan margin responsif

    // Memisahkan pelanggan yang memiliki dan tidak memiliki latitude/longitude
    List kontakWithLatLong = submitPengantaranModel.kontaks
        .where((kontak) =>
            kontak.latitude.isNotEmpty && kontak.longitude.isNotEmpty)
        .toList();
    List kontakWithoutLatLong = submitPengantaranModel.kontaks
        .where((kontak) => kontak.latitude.isEmpty || kontak.longitude.isEmpty)
        .toList();

    // Gabungkan, dengan kontak tanpa lat/long di bagian akhir
    List allKontaks = [...kontakWithLatLong, ...kontakWithoutLatLong];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Perjalanan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CustomColorPalette.textColor,
          ),
        ),
        backgroundColor: CustomColorPalette.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchDropdown()),
            );
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(
                      left: marginSize,
                      right: marginSize,
                      bottom: 20,
                    ), // Margin bottom added
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Pengiriman',
                          style: TextStyle(
                            fontSize:
                                getFontSize(context, 24), // Responsif font size
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF363535),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: Text(
                            capitalizeWords(submitPengantaranModel.namaDriver),
                            style: TextStyle(
                              fontSize: getFontSize(
                                  context, 20), // Responsif font size
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF363535),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              buildRow(
                                  'Shift',
                                  submitPengantaranModel.shiftKe.toString(),
                                  context),
                              buildRow(
                                  'Jam Pengiriman',
                                  submitPengantaranModel.jamPengiriman ?? '',
                                  context),
                              buildRow(
                                  'Jam Kembali',
                                  submitPengantaranModel.jamKembali ?? '',
                                  context),
                              buildRow(
                                  'Tipe Kendaraan',
                                  submitPengantaranModel.tipeKendaraan,
                                  context),
                              buildRow(
                                  'Nomor Polisi',
                                  submitPengantaranModel.nomorPolisiKendaraan,
                                  context),
                              buildRow('Created By',
                                  submitPengantaranModel.createdBy, context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(
                      left: marginSize,
                      right: marginSize,
                      bottom: 20,
                    ), // Margin bottom added
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Customers',
                          style: TextStyle(
                            fontSize:
                                getFontSize(context, 24), // FontSize responsif
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF363535),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Mapping dari data kontak, urutkan berdasarkan urutan pengiriman
                        ...allKontaks.map((kontak) => ListTile(
                              title: Text(
                                kontak.displayName,
                                style: TextStyle(
                                  fontSize: getFontSize(
                                      context, 20), // FontSize responsif
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF363535),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildRow(
                                      'Urutan Pengiriman',
                                      kontak.urutanPengiriman.toString(),
                                      context),
                                  if (kontak.latitude.isEmpty ||
                                      kontak.longitude.isEmpty)
                                    const Text(
                                      'Pelanggan ini tidak memiliki latitude/longitude',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: getLabelWidth(
                                              context), // Lebar kolom label responsif
                                          child: Text(
                                            'Latitude',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  getFontSize(context, 18),
                                              color:
                                                  CustomColorPalette.textColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontSize: getFontSize(context,
                                                20), // Ukuran font responsif
                                            color: CustomColorPalette.textColor,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            kontak.latitude.isEmpty
                                                ? 'Tidak ada'
                                                : kontak.latitude,
                                            style: TextStyle(
                                              fontSize:
                                                  getFontSize(context, 20),
                                              color:
                                                  CustomColorPalette.textColor,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.location_on_rounded,
                                            size: getIconSize(context,
                                                30), // Ukuran ikon responsif
                                            color: const Color(0xFF8A2BE2),
                                          ),
                                          onPressed: () {
                                            if (kontak.longitude != '') {
                                              launch(
                                                'https://www.google.com/maps/search/?api=1&query=${kontak.latitude},${kontak.longitude}',
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  buildRow(
                                    'Longitude',
                                    kontak.longitude.isEmpty
                                        ? 'Tidak ada'
                                        : kontak.longitude,
                                    context,
                                  ),
                                  buildRow('Lokasi', kontak.lokasi, context),
                                  buildRow('Nomor Faktur',
                                      kontak.nomorFaktur.toString(), context),
                                  const Divider(color: Colors.purple),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),

                  // Container Google Maps dan Distance/Duration
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(
                      left: marginSize,
                      right: marginSize,
                      bottom: 20,
                    ), // Margin bottom added
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Google Maps',
                              style: TextStyle(
                                fontSize: getFontSize(
                                    context, 24), // Ukuran font responsif
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF363535),
                              ),
                            ),
                            // Ikon Google Maps dengan ukuran responsif
                            IconButton(
                              icon: Icon(
                                Icons.map_rounded,
                                size: getIconSize(
                                    context, 30), // Ukuran ikon responsif
                                color: const Color(0xFF8A2BE2),
                              ),
                              onPressed: () {
                                launch(submitPengantaranModel.googleMapsUrl);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                buildRow(
                                    'Min Distance',
                                    '${submitPengantaranModel.minDistance.toStringAsFixed(2)} km',
                                    context),
                                const SizedBox(height: 8),
                                buildRow(
                                    'Min Duration',
                                    '${submitPengantaranModel.minDuration.toStringAsFixed(2)} minutes',
                                    context),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
