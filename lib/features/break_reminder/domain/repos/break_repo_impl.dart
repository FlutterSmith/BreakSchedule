import 'dart:async';
import 'dart:math';
import 'package:break_reminder_app/core/notification_service.dart';
import 'package:break_reminder_app/features/break_reminder/domain/repos/break_repo.dart';

import '../../domain/entities/break_schedule.dart';

class BreakRepositoryImpl implements BreakRepository {
  Timer? _scheduleTimer;
  final StreamController<int> _breakController = StreamController.broadcast();
  int _notificationId = 0;

  @override
  void startSchedule(BreakSchedule schedule) {
    _scheduleTimer?.cancel();
    _scheduleTimer = Timer.periodic(Duration(minutes: schedule.frequency), (timer) {
      _breakController.add(schedule.breakLength);
      NotificationService.instance.showNotification(
        _notificationId++,
        "It's break time!",
        "Take a break now.",
      );
    });
  }

  @override
  void stopSchedule() {
    _scheduleTimer?.cancel();
    _scheduleTimer = null;
  }

  @override
  Stream<int> get breakTriggerStream => _breakController.stream;
}
