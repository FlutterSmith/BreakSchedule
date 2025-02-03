import 'package:break_reminder_app/core/widgets/custom_button.dart';
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
    final size = MediaQuery.of(context).size;
    return BlocListener<BreakBloc, BreakState>(
      listener: (context, state) {
        if (state is BreakTimeState) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BreakScreen(breakLength: state.breakLength),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween =
                    Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Break Reminder Home'),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF2196F3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Break Length: ${schedule.breakLength} min',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('Break Frequency: ${schedule.frequency} min',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: 32),
                  BlocBuilder<BreakBloc, BreakState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: state is ScheduleRunningState
                            ? CustomButton(
                                key: const ValueKey("stop"),
                                onPressed: () {
                                  context.read<BreakBloc>().add(StopScheduleEvent());
                                },
                                icon: const Icon(Icons.pause),
                                label: 'Stop Schedule',
                                color: Colors.redAccent,
                              )
                            : CustomButton(
                                key: const ValueKey("start"),
                                onPressed: () {
                                  context.read<BreakBloc>().add(StartScheduleEvent());
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: 'Start Schedule',
                                color: Colors.green,
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
