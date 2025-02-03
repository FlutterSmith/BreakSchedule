import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'break_event.dart';
import 'break_state.dart';
import '../../domain/entities/break_schedule.dart';
import '../../data/repositories/break_repository_impl.dart';

class BreakBloc extends Bloc<BreakEvent, BreakState> {
  final BreakRepositoryImpl _repository = BreakRepositoryImpl();
  StreamSubscription<int>? _breakSubscription;
  BreakSchedule? _currentSchedule;

  BreakBloc() : super(BreakInitialState()) {
    on<SetScheduleEvent>(_onSetSchedule);
    on<StartScheduleEvent>(_onStartSchedule);
    on<StopScheduleEvent>(_onStopSchedule);
    on<BreakTriggeredEvent>(_onBreakTriggered);
  }

  void _onSetSchedule(SetScheduleEvent event, Emitter<BreakState> emit) {
    _currentSchedule = event.schedule;
    emit(ScheduleSetState(event.schedule));
  }

  void _onStartSchedule(StartScheduleEvent event, Emitter<BreakState> emit) {
    if (_currentSchedule == null) return;
    _repository.startSchedule(_currentSchedule!);
    _breakSubscription?.cancel();
    _breakSubscription = _repository.breakTriggerStream.listen((breakLength) {
      add(BreakTriggeredEvent(breakLength));
    });
    emit(ScheduleRunningState(_currentSchedule!));
  }

  void _onStopSchedule(StopScheduleEvent event, Emitter<BreakState> emit) {
    _repository.stopSchedule();
    _breakSubscription?.cancel();
    emit(ScheduleStoppedState());
  }

  void _onBreakTriggered(BreakTriggeredEvent event, Emitter<BreakState> emit) {
    emit(BreakTimeState(event.breakLength));
  }

  @override
  Future<void> close() {
    _repository.stopSchedule();
    _breakSubscription?.cancel();
    return super.close();
  }
}
