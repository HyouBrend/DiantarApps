// submit_event.dart
import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';

abstract class SubmitEvent extends Equatable {
  const SubmitEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPengantaranEvent extends SubmitEvent {
  final DetailPengantaranModel detailPengantaran;

  const SubmitPengantaranEvent(this.detailPengantaran);

  @override
  List<Object?> get props => [detailPengantaran];
}
