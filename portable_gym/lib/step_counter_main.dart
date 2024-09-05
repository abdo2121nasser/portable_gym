// import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';
// import 'dart:async';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() => runApp(StepCounterApp());
//
// class StepCounterApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Step Counter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StepCounterHomePage(),
//     );
//   }
// }
//
// class StepCounterHomePage extends StatefulWidget {
//   @override
//   _StepCounterHomePageState createState() => _StepCounterHomePageState();
// }
//
// class _StepCounterHomePageState extends State<StepCounterHomePage> {
//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;
//   String _status = 'stopped', _steps = '0';
//   int _lastRecordedSteps = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//   }
//
//   Future<void> requestPermissions() async {
//     if (await Permission.activityRecognition.request().isGranted) {
//       await checkFirstLaunch();
//       initPlatformState();
//     } else {
//       setState(() {
//         _steps = 'Permission not granted';
//       });
//     }
//   }
//
//   Future<void> checkFirstLaunch() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
//
//     if (isFirstLaunch) {
//       await resetCounter();
//       prefs.setBool('firstLaunch', false);
//     }
//   }
//
//   Future<void> resetCounter() async {
//     final prefs = await SharedPreferences.getInstance();
//     String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     prefs.setInt('lastRecordedSteps', 0); // Reset the last recorded steps
//     _lastRecordedSteps = 0;
//   }
//
//   Future<void> initPlatformState() async {
//     try {
//       _stepCountStream = Pedometer.stepCountStream;
//       _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//
//       _stepCountStream.listen(onStepCount).onError(onStepCountError);
//       _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
//
//       if (!mounted) return;
//
//       final prefs = await SharedPreferences.getInstance();
//       _lastRecordedSteps = prefs.getInt('lastRecordedSteps') ?? 0;
//     } catch (e) {
//       print("Error initializing pedometer: $e");
//     }
//   }
//
//   void onStepCount(StepCount event) async {
//     int currentSteps = event.steps;
//     int stepsSinceLastReset = currentSteps - _lastRecordedSteps;
//
//     setState(() {
//       _steps = stepsSinceLastReset.toString();
//     });
//
//     await saveStepCount(currentSteps);
//   }
//
//   Future<void> saveStepCount(int steps) async {
//     final prefs = await SharedPreferences.getInstance();
//     String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     prefs.setInt(today, steps);
//     prefs.setInt('lastRecordedSteps', steps); // Update last recorded steps
//   }
//
//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print('Pedestrian status event: ${event.status}');
//     setState(() {
//       _status = event.status;
//     });
//   }
//
//   void onPedestrianStatusError(error) {
//     print('Pedestrian status error: $error');
//     setState(() {
//       _status = 'Pedestrian Status not available';
//     });
//   }
//
//   void onStepCountError(error) {
//     print('Step count error: $error');
//     setState(() {
//       _steps = 'Step Count not available';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Step Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Steps taken since last reset:',
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               _steps,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Status:',
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               _status,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await resetCounter();
//                 setState(() {
//                   _steps = '0'; // Reset display value
//                 });
//               },
//               child: Text('Reset Counter'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
