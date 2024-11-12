import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_state.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/produk_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/theme/theme.dart';

class DropdownProduct extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onCategorySelected;
  final Function(DropdownProductModel) onProductSelected;

  const DropdownProduct({
    Key? key,
    required this.controller,
    required this.onCategorySelected,
    required this.onProductSelected,
  }) : super(key: key);

  @override
  _DropdownProductState createState() => _DropdownProductState();
}

class _DropdownProductState extends State<DropdownProduct> {
  DropdownProductModel? selectedProduct;
  bool _isLoading = false;
  final List<String> filteredProductNames = [
    "Le Mineral 1500 ML",
    "Le Mineral 330 ML",
    "Le Mineral 600 ML",
    "Le Mineral Galon 15 L"
  ];

  String getShortenedProductName(String fullName) {
    switch (fullName) {
      case 'Le Mineral 1500 ML':
        return 'Le min 1500';
      case 'Le Mineral 330 ML':
        return 'Le min 330';
      case 'Le Mineral 600 ML':
        return 'Le min 600';
      case 'Le Mineral Galon 15 L':
        return 'Le min galon';
      default:
        return fullName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Sizes.dp94(context),
          child: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductLoading) {
                setState(() => _isLoading = true);
              } else {
                setState(() => _isLoading = false);
              }
              if (state is ProductError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: TypeAheadFormField<DropdownProductModel>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: 'Produk',
                  hintText: 'Masukkan nama produk',
                  labelStyle: const TextStyle(fontSize: 14),
                  hintStyle: TextStyle(
                      color: CustomColorPalette.hintTextColor, fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  fillColor: CustomColorPalette.surfaceColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 14),
              ),
              suggestionsCallback: (pattern) async {
                context.read<ProductBloc>().add(FetchProducts(query: pattern));

                final state =
                    await context.read<ProductBloc>().stream.firstWhere(
                          (state) => state is! ProductLoading,
                        );

                if (state is ProductHasData) {
                  return state.products.where((product) =>
                      filteredProductNames.contains(product.name) &&
                      product.name!
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));
                }
                return [];
              },
              itemBuilder: (context, DropdownProductModel suggestion) {
                return ListTile(
                  title: Text(
                    getShortenedProductName(suggestion.name ?? ''),
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
              onSuggestionSelected: (DropdownProductModel suggestion) {
                setState(() {
                  widget.controller.text =
                      getShortenedProductName(suggestion.name ?? '');
                  widget.onCategorySelected(suggestion.productCategory ?? '');
                  selectedProduct = suggestion;
                  widget.onProductSelected(suggestion);
                });
              },
              noItemsFoundBuilder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Produk tidak ditemukan',
                  style: TextStyle(
                    color: CustomColorPalette.textColor,
                    fontSize: 14,
                  ),
                ),
              ),
              loadingBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              hideOnLoading: !_isLoading,
              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                constraints: BoxConstraints(maxHeight: 500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
