import 'package:equatable/equatable.dart';
import '../../domain/entities/break_schedule.dart';

abstract class BreakEvent extends Equatable {
  const BreakEvent();
  @override
  List<Object?> get props => [];
}

class SetScheduleEvent extends BreakEvent {
  final BreakSchedule schedule;
  const SetScheduleEvent(this.schedule);
  @override
  List<Object?> get props => [schedule];
}

class StartScheduleEvent extends BreakEvent {}

class StopScheduleEvent extends BreakEvent {}

class BreakTriggeredEvent extends BreakEvent {
  final int breakLength;
  const BreakTriggeredEvent(this.breakLength);
  @override
  List<Object?> get props => [breakLength];
}
