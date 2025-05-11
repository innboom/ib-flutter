import 'package:bloc/bloc.dart';

import 'pm_appbar_event.dart';
import 'pm_appbar_state.dart';

class PmAppbarBloc extends Bloc<PmAppbarEvent, PmAppbarState> {
  PmAppbarBloc() : super(PmAppbarState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<PmAppbarState> emit) async {
    emit(state.clone());
  }
}
