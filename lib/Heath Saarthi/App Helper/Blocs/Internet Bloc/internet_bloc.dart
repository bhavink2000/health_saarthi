import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_event.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState>{

  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetIntialState()){

    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));

    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    _connectivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        add(InternetGainedEvent());
      }
      else{
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}