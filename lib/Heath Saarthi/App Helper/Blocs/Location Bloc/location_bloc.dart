//@dart=2.9
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Location%20Bloc/location_event.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Location%20Bloc/location_state.dart';

import 'location_repo.dart';

class LocationBloc extends Bloc<StateEvent, StateDataState>{
  final LocationRepo locationRepo;

  LocationBloc(this.locationRepo) : super(StateLoadingState()){
    on<LoadStateEvent>((event, emit) async{
      emit(StateLoadingState());
      try{
        final state = await locationRepo.getState();
        emit(StateLoadedState(state));
      }
      catch(e){
        emit(StateErrorState(e.toString()));
      }
    });
  }
}