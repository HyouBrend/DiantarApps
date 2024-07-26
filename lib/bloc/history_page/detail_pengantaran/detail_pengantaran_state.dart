import 'package:diantar_jarak/data/models/model_history_page/model_detail_pengantaran_page.dart';
import 'package:equatable/equatable.dart';

abstract class DetailPengantaranState extends Equatable {
  const DetailPengantaranState();

  @override
  List<Object> get props => [];
}

class DetailPengantaranInitial extends DetailPengantaranState {}

class DetailPengantaranLoading extends DetailPengantaranState {}

class DetailPengantaranLoaded extends DetailPengantaranState {
  final List<DetailPengantaran> detailPengantaran;

  const DetailPengantaranLoaded(this.detailPengantaran);

  @override
  List<Object> get props => [detailPengantaran];
}

class DetailPengantaranError extends DetailPengantaranState {
  final String message;

  const DetailPengantaranError(this.message);

  @override
  List<Object> get props => [message];
}
