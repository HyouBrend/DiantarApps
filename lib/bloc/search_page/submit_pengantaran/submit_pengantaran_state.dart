import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';
import 'package:equatable/equatable.dart';

abstract class SubmitPengantaranState extends Equatable {
  const SubmitPengantaranState();

  @override
  List<Object> get props => [];
}

class SubmitPengantaranInitial extends SubmitPengantaranState {}

class PengantaranSubmitting extends SubmitPengantaranState {}

class PengantaranSubmitted extends SubmitPengantaranState {
  final DetailPengantaran detailPengantaran;

  const PengantaranSubmitted({required this.detailPengantaran});

  @override
  List<Object> get props => [detailPengantaran];
}

class SubmitPengantaranError extends SubmitPengantaranState {
  final String message;

  const SubmitPengantaranError({required this.message});

  @override
  List<Object> get props => [message];
}
