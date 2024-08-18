import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialFetchEvent>(dashboardInitialFetchEvent);
  }

  FutureOr<void> dashboardInitialFetchEvent(
    DashboardInitialFetchEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

  }

}
