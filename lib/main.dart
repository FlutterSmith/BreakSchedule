import 'package:break_reminder_app/features/break_reminder/presentation/bloc/breal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/break_reminder/presentation/screens/setup_screen.dart';
import 'core/notification_service.dart';
import 'core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  runApp(
    BlocProvider<BreakBloc>(
      create: (_) => BreakBloc(),
      child: BreakReminderApp(),
    ),
  );
}

class BreakReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Break Reminder',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SetupScreen(),
    );
  }
}
