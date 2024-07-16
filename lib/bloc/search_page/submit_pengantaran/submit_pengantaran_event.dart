import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';

abstract class SubmitPengantaranEvent extends Equatable {
  const SubmitPengantaranEvent();

  @override
  List<Object> get props => [];
}

class SubmitPengantaran extends SubmitPengantaranEvent {
  final DetailPengantaran detailPengantaran;
  final DateTime waktuPesanan;

  SubmitPengantaran({
    required this.detailPengantaran,
    required this.waktuPesanan,
  });

  @override
  List<Object> get props => [detailPengantaran, waktuPesanan];
}
