import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';

class DeliverOrderPaginationControls extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final int rowsPerPage;
  final int totalItems;
  final TextEditingController pageController;
  final Function(int, int) onPageChanged;

  const DeliverOrderPaginationControls({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.rowsPerPage,
    required this.totalItems,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  _DeliverOrderPaginationControlsState createState() =>
      _DeliverOrderPaginationControlsState();
}

class _DeliverOrderPaginationControlsState
    extends State<DeliverOrderPaginationControls> {
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage;
  }

  void _onRowsPerPageChanged(int? value) {
    if (value != null && value != _rowsPerPage) {
      setState(() {
        _rowsPerPage = value;
      });
      widget.pageController.text = '1'; // Reset to page 1
      widget.onPageChanged(1, _rowsPerPage); // Trigger data fetch
    }
  }

  void _submitPageChange(int displayedPage, int displayedTotalPages) {
    final page = int.tryParse(widget.pageController.text) ?? 1;

    if (page > 0 && page <= displayedTotalPages) {
      widget.onPageChanged(page, _rowsPerPage);
    } else {
      widget.pageController.text = displayedPage.toString(); // Reset if invalid
    }
  }

  Widget _buildStyledTextField(int displayedPage, int displayedTotalPages) {
    return Container(
      width: 60,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CustomColorPalette.lavender,
        border: Border.all(color: CustomColorPalette.textColor),
        borderRadius: BorderRadius.circular(10),
      ),
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
          decoration: const InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
          ),
          onSubmitted: (value) {
            _submitPageChange(displayedPage, displayedTotalPages);
          },
        ),
      ),
    );
  }

  Widget _buildPageSizeSelector(int totalItems) {
    return Row(
      children: [
        const Text(
          'Menampilkan ',
          style: TextStyle(fontSize: 16),
        ),
        Container(
          width: 60,
          height: 40,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: CustomColorPalette.lavender,
            border: Border.all(color: CustomColorPalette.textColor),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _rowsPerPage,
              items: [10, 25, 50, 100].map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Center(
                    child: Text(
                      '$value',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
              onChanged: _onRowsPerPageChanged,
              icon: const SizedBox.shrink(), // Remove dropdown arrow icon
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

  @override
  Widget build(BuildContext context) {
    widget.pageController.text = widget.currentPage.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPageSizeSelector(widget.totalItems),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: widget.currentPage > 1
                    ? () => widget.onPageChanged(
                        widget.currentPage - 1, _rowsPerPage)
                    : null,
              ),
              _buildStyledTextField(widget.currentPage, widget.totalPages),
              Text(' of ${widget.totalPages} pages'),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: widget.currentPage < widget.totalPages
                    ? () => widget.onPageChanged(
                        widget.currentPage + 1, _rowsPerPage)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
