import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final timerProvider =
    ChangeNotifierProvider<TimerProvider>((ref) => TimerProvider());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: homeScreenBody(timer),
    );
  }

  Widget homeScreenBody(TimerProvider timer) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              border: Border.all(width: 5, color: Colors.blue),
              // borderRadius: BorderRadius,
            ),
            child: Center(
              child: Text(
                '${timer.hour} : ${timer.minute} : ${timer.seconds} ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            (timer.startEnable)
                ? ElevatedButton(
                    onPressed: timer.startTimer,
                    child: const Text('Start'),
                  )
                : const ElevatedButton(
                    onPressed: null,
                    child: Text('Start'),
                  ),
            (timer.stopEnable)
                ? ElevatedButton(
                    onPressed: timer.stopTimer,
                    child: const Text('Stop'),
                  )
                : const ElevatedButton(
                    onPressed: null,
                    child: Text('Stop'),
                  ),
            (timer.continueEnable)
                ? ElevatedButton(
                    onPressed: timer.continueTimer,
                    child: const Text('Continue'),
                  )
                : const ElevatedButton(
                    onPressed: null,
                    child: Text('Continue'),
                  ),
          ],
        ),
      ],
    );
  }
}

class TimerProvider extends ChangeNotifier {
  late Timer _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;

  void startTimer() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }

  void stopTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer.cancel();
    }
    notifyListeners();
  }

  void continueTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }
}
