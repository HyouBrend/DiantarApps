import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';

class PaginationControls extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final int rowsPerPage;
  final int totalItems;
  final TextEditingController pageController;
  final Function(int) onPageChanged;

  const PaginationControls({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.rowsPerPage,
    required this.totalItems,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  _PaginationControlsState createState() => _PaginationControlsState();
}

class _PaginationControlsState extends State<PaginationControls> {
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage;

    // Memanggil pemuatan data ketika widget pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  // Fungsi untuk memicu refresh data
  void _refreshData() {
    context.read<HistoryPengantaranBloc>().add(
          FetchHistoryPengantaran(
            page: widget.currentPage,
            pageSize: _rowsPerPage,
            filters: {}, // Bisa tambahkan filter jika ada
          ),
        );
  }

  // Callback untuk menangani perubahan jumlah baris per halaman
  void _onRowsPerPageChanged(int? value) {
    if (value != null) {
      setState(() {
        _rowsPerPage = value;
      });
      widget.pageController.text = '1'; // Reset ke halaman 1
      widget.onPageChanged(1); // Pindah ke halaman pertama
      _refreshData(); // Refresh data setelah perubahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: BlocBuilder<HistoryPengantaranBloc, HistoryPengantaranState>(
        builder: (context, state) {
          int displayedPage = widget.currentPage;
          int displayedTotalPages = widget.totalPages;
          int totalItems = widget.totalItems;

          if (state is HistoryLoaded) {
            displayedPage = state.currentPage;
            displayedTotalPages = state.totalPages;
            totalItems = state.totalItems;
          }

          widget.pageController.text = displayedPage.toString();

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPageInfoWithCustomDropdown(totalItems),
              _buildPageNavigation(displayedPage, displayedTotalPages),
            ],
          );
        },
      ),
    );
  }

  // Widget untuk informasi dan dropdown yang terlihat seperti TextField
  // Widget untuk informasi dan dropdown dengan ukuran konsisten seperti TextField
  Widget _buildPageInfoWithCustomDropdown(int totalItems) {
    return Row(
      children: [
        const Text(
          'Menampilkan ',
          style: TextStyle(fontSize: 16),
        ),
        _buildStyledContainer(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _rowsPerPage,
              items: [10, 25, 50, 100]
                  .map(
                    (value) => DropdownMenuItem<int>(
                      value: value,
                      child: Center(
                        child: Text(
                          '$value',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: _onRowsPerPageChanged,
              icon: const SizedBox.shrink(), // Hilangkan icon panah
              isExpanded: true,
              dropdownColor: Colors.white,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'dari $totalItems',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

// Widget TextField dengan ukuran konsisten seperti dropdown
  Widget _buildStyledTextField(int displayedPage, int displayedTotalPages) {
    return _buildStyledContainer(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            _submitPageChange(displayedPage, displayedTotalPages);
          }
        },
        child: TextField(
          controller: widget.pageController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            isCollapsed: true, // Hilangkan padding ekstra bawaan
            border: InputBorder.none, // Hilangkan border default
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          ),
          onSubmitted: (value) {
            _submitPageChange(displayedPage, displayedTotalPages);
          },
        ),
      ),
    );
  }

// Fungsi untuk memproses perubahan halaman
  void _submitPageChange(int displayedPage, int displayedTotalPages) {
    final page = int.tryParse(widget.pageController.text) ?? 1;

    if (page > 0 && page <= displayedTotalPages) {
      widget.onPageChanged(page);
      _refreshData(); // Refresh data setelah pindah halaman
    } else {
      widget.pageController.text =
          displayedPage.toString(); // Reset jika input tidak valid
    }
  }

// Fungsi reusable untuk memastikan ukuran seragam
  Widget _buildStyledContainer({required Widget child}) {
    return Container(
      width: 60,
      height: 40,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

// Widget untuk input halaman dan navigasi dengan ukuran konsisten
  Widget _buildPageNavigation(int displayedPage, int displayedTotalPages) {
    return Row(
      children: [
        _buildStyledTextField(displayedPage, displayedTotalPages),
        const SizedBox(width: 8),
        Text(
          'dari $displayedTotalPages halaman',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: displayedPage > 1
              ? () => widget.onPageChanged(displayedPage - 1)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: displayedPage < displayedTotalPages
              ? () => widget.onPageChanged(displayedPage + 1)
              : null,
        ),
      ],
    );
  }
}
