import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_event.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_state.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_customer_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerService customerService;

  CustomerBloc({required this.customerService}) : super(CustomerInitial()) {
    on<FetchCustomers>(_onFetchCustomers);
    // Fetch customers initially with empty query
    add(FetchCustomers(''));
  }

  void _onFetchCustomers(
      FetchCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final result = await customerService.getCustomers(event.query);
      print('Fetched Customers: ${result.data}'); // Debug print
      final filteredCustomers = result.data
              ?.where((customer) =>
                  customer.displayName
                      ?.toLowerCase()
                      .contains(event.query.toLowerCase()) ??
                  false)
              .toList() ??
          [];
      emit(CustomerLoaded(filteredCustomers));
    } catch (e) {
      emit(CustomerError('Failed to fetch customers: $e'));
    }
  }
}
