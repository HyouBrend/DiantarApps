import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final String query;

  const FetchProducts({required this.query});

  @override
  List<Object> get props => [query];
}
