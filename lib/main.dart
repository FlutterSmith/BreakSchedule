import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/break_reminder/presentation/bloc/break_bloc.dart';
import 'features/break_reminder/presentation/screens/setup_screen.dart';
import 'core/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  runApp(BreakReminderApp());
}

class BreakReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Break Reminder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<BreakBloc>(
        create: (_) => BreakBloc(),
        child: SetupScreen(),
      ),
    );
  }
}
