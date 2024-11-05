import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_widget/card_history.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_widget/filter_history.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_widget/paging_history.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';

class HistoryPengantaranPage extends StatefulWidget {
  @override
  _HistoryPengantaranPageState createState() => _HistoryPengantaranPageState();
}

class _HistoryPengantaranPageState extends State<HistoryPengantaranPage> {
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalPages = 1;
  int totalItems = 0;
  bool _isFirstLoad = true;

  // Filter dengan dynamic type
  Map<String, dynamic> currentFilters = {};

  final TextEditingController pageController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      _fetchData(); // Fetch saat pertama kali widget di-load
      _isFirstLoad = false;
    }
  }

  // Gunakan helper untuk konversi sebelum mengirim ke Bloc
  void _fetchData() {
    final filters = _convertFilters(currentFilters); // Konversi filter

    context.read<HistoryPengantaranBloc>().add(
          FetchHistoryPengantaran(
            page: currentPage,
            pageSize: rowsPerPage,
            filters: filters, // Kirim filter terkonversi
          ),
        );
  }

  Map<String, String> _convertFilters(Map<String, dynamic> filters) {
    return filters.map((key, value) => MapEntry(key, value?.toString() ?? ''));
  }

  void _onFilterChanged(Map<String, dynamic> filters) {
    setState(() {
      currentFilters = filters;
      currentPage = 1;
      pageController.text = '1'; // Reset halaman ke 1
    });
    _fetchData();
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      pageController.text = page.toString(); // Update textfield
    });
    _fetchData();
  }

  void _onRowsPerPageChanged(int? value) {
    if (value != null) {
      setState(() {
        rowsPerPage = value;
        currentPage = 1;
        pageController.text = '1'; // Reset halaman ke 1
      });
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Pengantaran'),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _getResponsiveMargin(context),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilterWidget(onFilterChanged: _onFilterChanged),
            ),
            Expanded(
              child:
                  BlocBuilder<HistoryPengantaranBloc, HistoryPengantaranState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HistoryLoaded) {
                    totalPages = state.totalPages;
                    totalItems = state.totalItems;

                    // Tampilkan list dengan CardHistory
                    return ListView.builder(
                      itemCount: state.histories.length,
                      itemBuilder: (context, index) {
                        final item = state.histories[index];

                        // Panggil CardHistory dengan item yang sesuai
                        return CardHistory(
                          historyItem: item,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Tidak ada data yang tersedia'),
                    );
                  }
                },
              ),
            ),
            PaginationControls(
              currentPage: currentPage,
              totalPages: totalPages,
              rowsPerPage: rowsPerPage,
              totalItems:
                  totalItems, // Tambahkan ini untuk menghitung jumlah item
              pageController: pageController,
              onPageChanged: _onPageChanged,
            ),
          ],
        ),
      ),
    );
  }

  double _getResponsiveMargin(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1024) {
      return 200; // Margin besar untuk desktop
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      return 150; // Margin sedang untuk tablet
    } else {
      return 20; // Margin kecil untuk mobile
    }
  }
}
