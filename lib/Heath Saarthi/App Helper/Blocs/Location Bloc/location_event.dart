import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class StateEvent extends Equatable {
  const StateEvent();
}

class LoadStateEvent extends StateEvent {
  @override
  List<Object?> get props => [];
}