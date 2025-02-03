import '../../domain/entities/break_schedule.dart';

class BreakScheduleModel extends BreakSchedule {
  const BreakScheduleModel({
    required int breakLength,
    required int frequency,
    required String notificationType,
  }) : super(breakLength: breakLength, frequency: frequency, notificationType: notificationType);

  factory BreakScheduleModel.fromEntity(BreakSchedule schedule) {
    return BreakScheduleModel(
      breakLength: schedule.breakLength,
      frequency: schedule.frequency,
      notificationType: schedule.notificationType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakLength': breakLength,
      'frequency': frequency,
      'notificationType': notificationType,
    };
  }

  factory BreakScheduleModel.fromJson(Map<String, dynamic> json) {
    return BreakScheduleModel(
      breakLength: json['breakLength'],
      frequency: json['frequency'],
      notificationType: json['notificationType'],
    );
  }
}
