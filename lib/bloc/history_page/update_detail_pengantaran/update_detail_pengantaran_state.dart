import 'package:equatable/equatable.dart';

abstract class UpdateDetailPengantaranState extends Equatable {
  const UpdateDetailPengantaranState();

  @override
  List<Object> get props => [];
}

class UpdateDetailPengantaranInitial extends UpdateDetailPengantaranState {}

class UpdateDetailPengantaranLoading extends UpdateDetailPengantaranState {}

class UpdateDetailPengantaranSuccess extends UpdateDetailPengantaranState {}

class UpdateDetailPengantaranFailure extends UpdateDetailPengantaranState {
  final String error;

  const UpdateDetailPengantaranFailure(this.error);

  @override
  List<Object> get props => [error];
}
