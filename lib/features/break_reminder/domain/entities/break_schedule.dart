import 'package:equatable/equatable.dart';

class BreakSchedule extends Equatable {
  final int breakLength;
  final int frequency;
  final String notificationType;

  const BreakSchedule({
    required this.breakLength,
    required this.frequency,
    required this.notificationType,
  });

  @override
  List<Object?> get props => [breakLength, frequency, notificationType];
}
