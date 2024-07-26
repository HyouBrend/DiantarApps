import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_page_result/submit_pengantaran_model.dart';

abstract class SubmitPengantaranEvent extends Equatable {
  const SubmitPengantaranEvent();

  @override
  List<Object> get props => [];
}

class SubmitPengantaran extends SubmitPengantaranEvent {
  final SubmitPengantaranModel submitPengantaranModel;

  SubmitPengantaran({
    required this.submitPengantaranModel,
  });

  @override
  List<Object> get props => [submitPengantaranModel];
}
