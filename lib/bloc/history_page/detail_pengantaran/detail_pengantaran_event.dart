import 'package:equatable/equatable.dart';

abstract class DetailPengantaranEvent extends Equatable {
  const DetailPengantaranEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailPengantaran extends DetailPengantaranEvent {
  final String perjalananID;

  FetchDetailPengantaran({required this.perjalananID});

  @override
  List<Object> get props => [perjalananID];
}
