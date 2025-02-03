import 'package:equatable/equatable.dart';
import '../../domain/entities/break_schedule.dart';

abstract class BreakState extends Equatable {
  const BreakState();
  @override
  List<Object?> get props => [];
}

class BreakInitialState extends BreakState {}

class ScheduleSetState extends BreakState {
  final BreakSchedule schedule;
  const ScheduleSetState(this.schedule);
  @override
  List<Object?> get props => [schedule];
}

class ScheduleRunningState extends BreakState {
  final BreakSchedule schedule;
  const ScheduleRunningState(this.schedule);
  @override
  List<Object?> get props => [schedule];
}

class ScheduleStoppedState extends BreakState {}

class BreakTimeState extends BreakState {
  final int breakLength;
  const BreakTimeState(this.breakLength);
  @override
  List<Object?> get props => [breakLength];
}
