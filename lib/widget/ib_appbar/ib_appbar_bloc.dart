import 'package:bloc/bloc.dart';

import 'ib_appbar_event.dart';
import 'ib_appbar_state.dart';

class IbAppbarBloc extends Bloc<IbAppbarEvent, IbAppbarState> {
  IbAppbarBloc() : super(IbAppbarState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<IbAppbarState> emit) async {
    emit(state.clone());
  }
}
