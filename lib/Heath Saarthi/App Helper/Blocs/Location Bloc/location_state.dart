import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../Backend Helper/Models/Location Model/state_model.dart';

@immutable
abstract class StateDataState extends Equatable {}

class StateLoadingState extends StateDataState {
  @override
  List<Object?> get props => [];
}

class StateLoadedState extends StateDataState {
  final List<StateModel> statedata;
  StateLoadedState(this.statedata);
  @override
  List<Object?> get props => [statedata];
}

class StateErrorState extends StateDataState {
  final String error;
  StateErrorState(this.error);
  @override
  List<Object?> get props => [error];
}