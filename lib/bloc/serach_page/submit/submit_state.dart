import 'package:equatable/equatable.dart';

abstract class SubmitState extends Equatable {
  const SubmitState();

  @override
  List<Object> get props => [];
}

class SubmitInitial extends SubmitState {}

class SubmitInProgress extends SubmitState {}

class SubmitSuccess extends SubmitState {}
