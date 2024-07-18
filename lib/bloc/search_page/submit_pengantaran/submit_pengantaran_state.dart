import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_page_result/submit_pengantaran_model.dart';

abstract class SubmitPengantaranState extends Equatable {
  const SubmitPengantaranState();

  @override
  List<Object> get props => [];
}

class SubmitPengantaranInitial extends SubmitPengantaranState {}

class PengantaranSubmitting extends SubmitPengantaranState {}

class PengantaranSubmitted extends SubmitPengantaranState {
  final SubmitPengantaranModel detailPengantaran;
  final DateTime waktuPesanan;

  const PengantaranSubmitted({
    required this.detailPengantaran,
    required this.waktuPesanan,
  });

  @override
  List<Object> get props => [detailPengantaran, waktuPesanan];
}

class SubmitPengantaranError extends SubmitPengantaranState {
  final String message;

  const SubmitPengantaranError({required this.message});

  @override
  List<Object> get props => [message];
}
