import 'package:break_reminder_app/features/break_reminder/presentation/bloc/breal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
    'Custom': const BreakSchedule(
        breakLength: 10, frequency: 60, notificationType: 'push'),
    'Pomodoro': const BreakSchedule(
        breakLength: 5, frequency: 25, notificationType: 'push'),
    '52-17': const BreakSchedule(
        breakLength: 17, frequency: 52, notificationType: 'push'),
  };
  String _selectedSchedule = 'Custom';
  String _selectedNotificationType = 'push';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Setup Your Break Schedule'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF2196F3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.15, left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                // Animated header with Lottie
                SizedBox(
                  height: size.height * 0.2,
                  child: Lottie.asset(
                    'assets/lottie/setup_header.json',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                // Form container in a Card
                Card(
                  color: Colors.white.withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: _selectedSchedule,
                            decoration: InputDecoration(
                              labelText: 'Select a Schedule',
                              prefixIcon: const Icon(Icons.schedule),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
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
                                  _breakLengthController.text =
                                      schedule.breakLength.toString();
                                  _frequencyController.text =
                                      schedule.frequency.toString();
                                  _selectedNotificationType =
                                      schedule.notificationType;
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _breakLengthController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Break Length (minutes)',
                              prefixIcon: const Icon(Icons.timer),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.parse(value) <= 0) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _frequencyController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Frequency (minutes)',
                              prefixIcon: const Icon(Icons.repeat),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
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
                          const SizedBox(height: 16),
                          InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Notification Type',
                              prefixIcon: const Icon(Icons.notifications),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedNotificationType,
                                items: const [
                                  DropdownMenuItem(
                                      value: 'push',
                                      child: Text('Push Notification')),
                                  DropdownMenuItem(
                                      value: 'alarm', child: Text('Alarm')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNotificationType = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final schedule = BreakSchedule(
                                    breakLength:
                                        int.parse(_breakLengthController.text),
                                    frequency:
                                        int.parse(_frequencyController.text),
                                    notificationType: _selectedNotificationType,
                                  );
                                  context
                                      .read<BreakBloc>()
                                      .add(SetScheduleEvent(schedule));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(schedule: schedule)),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Save Schedule',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
