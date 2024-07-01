import 'package:equatable/equatable.dart';

abstract class SubmitEvent extends Equatable {
  const SubmitEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends SubmitEvent {}
