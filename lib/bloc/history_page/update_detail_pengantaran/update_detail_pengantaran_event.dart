import 'package:diantar_jarak/data/models/model_history_page/model_update_detail_pengantaran_page.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateDetailPengantaranEvent extends Equatable {
  const UpdateDetailPengantaranEvent();

  @override
  List<Object> get props => [];
}

class SubmitUpdateDetailPengantaran extends UpdateDetailPengantaranEvent {
  final UpdateDetailPengantaran updatePengantaran;

  const SubmitUpdateDetailPengantaran(this.updatePengantaran);

  @override
  List<Object> get props => [updatePengantaran];
}
