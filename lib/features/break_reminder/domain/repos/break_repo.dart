import '../entities/break_schedule.dart';

abstract class BreakRepository {
  void startSchedule(BreakSchedule schedule);
  void stopSchedule();
  Stream<int> get breakTriggerStream;
}
