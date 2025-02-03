import 'package:break_reminder_app/features/break_reminder/presentation/bloc/breal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/break_schedule.dart';
import '../bloc/break_event.dart';
import 'home_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _breakLengthController =
      TextEditingController(text: '10');
  final TextEditingController _frequencyController =
      TextEditingController(text: '60');
  final Map<String, BreakSchedule> preloadedSchedules = {
    'Custom': const BreakSchedule(breakLength: 10, frequency: 60, notificationType: 'push'),
    'Pomodoro': const BreakSchedule(breakLength: 5, frequency: 25, notificationType: 'push'),
    '52-17': const BreakSchedule(breakLength: 17, frequency: 52, notificationType: 'push'),
  };
  String _selectedSchedule = 'Custom';
  String _selectedNotificationType = 'push';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup Your Break Schedule')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedSchedule,
              decoration: const InputDecoration(
                labelText: 'Select a Schedule',
                border: OutlineInputBorder(),
              ),
              items: preloadedSchedules.keys
                  .map((schedule) => DropdownMenuItem(
                        value: schedule,
                        child: Text(schedule),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSchedule = value!;
                  if (value != 'Custom') {
                    final schedule = preloadedSchedules[value]!;
                    _breakLengthController.text = schedule.breakLength.toString();
                    _frequencyController.text = schedule.frequency.toString();
                    _selectedNotificationType = schedule.notificationType;
                  }
                });
              },
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _breakLengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Break Length (minutes)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Enter a valid number of minutes';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _frequencyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Frequency (minutes)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Enter a valid frequency';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Notification Type',
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedNotificationType,
                        items: const [
                          DropdownMenuItem(value: 'push', child: Text('Push Notification')),
                          DropdownMenuItem(value: 'alarm', child: Text('Alarm')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedNotificationType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final schedule = BreakSchedule(
                          breakLength: int.parse(_breakLengthController.text),
                          frequency: int.parse(_frequencyController.text),
                          notificationType: _selectedNotificationType,
                        );
                        context.read<BreakBloc>().add(SetScheduleEvent(schedule));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(schedule: schedule)),
                        );
                      }
                    },
                    child: const Text('Save Schedule'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
