// submit_state.dart
import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';

abstract class SubmitState extends Equatable {
  const SubmitState();

  @override
  List<Object?> get props => [];
}

class SubmitInitial extends SubmitState {}

class SubmitLoading extends SubmitState {}

class SubmitSuccess extends SubmitState {
  final DetailPengantaranModel response;

  const SubmitSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class SubmitFailure extends SubmitState {
  final String error;

  const SubmitFailure(this.error);

  @override
  List<Object?> get props => [error];
}
