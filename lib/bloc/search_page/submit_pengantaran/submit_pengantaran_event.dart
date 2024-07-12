import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';
import 'package:equatable/equatable.dart';

abstract class SubmitPengantaranEvent extends Equatable {
  const SubmitPengantaranEvent();

  @override
  List<Object> get props => [];
}

class SubmitPengantaran extends SubmitPengantaranEvent {
  final DetailPengantaran detailPengantaran;

  SubmitPengantaran({required this.detailPengantaran});

  @override
  List<Object> get props => [detailPengantaran];
}
