import 'package:break_reminder_app/features/break_reminder/presentation/bloc/breal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/break_schedule.dart';
import '../bloc/break_event.dart';
import '../bloc/break_state.dart';
import 'setup_screen.dart';
import 'break_screen.dart';

class HomeScreen extends StatelessWidget {
  final BreakSchedule schedule;
  const HomeScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreakBloc, BreakState>(
      listener: (context, state) {
        if (state is BreakTimeState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakScreen(breakLength: state.breakLength),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Break Reminder Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                context.read<BreakBloc>().add(StopScheduleEvent());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SetupScreen()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Break Length: ${schedule.breakLength} min',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Break Frequency: ${schedule.frequency} min',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              BlocBuilder<BreakBloc, BreakState>(
                builder: (context, state) {
                  if (state is ScheduleRunningState) {
                    return ElevatedButton.icon(
                      onPressed: () {
                        context.read<BreakBloc>().add(StopScheduleEvent());
                      },
                      icon: const Icon(Icons.pause),
                      label: const Text('Stop Schedule'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    );
                  } else {
                    return ElevatedButton.icon(
                      onPressed: () {
                        context.read<BreakBloc>().add(StartScheduleEvent());
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Schedule'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
