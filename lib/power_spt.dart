import 'package:flutter/material.dart';
import 'dart:async';

class PowerSPTPage extends StatefulWidget {
  const PowerSPTPage({super.key, required this.title});

  final String title;

  @override
  State<PowerSPTPage> createState() => _PowerSPTPageState();  
}

class _PowerSPTPageState extends State<PowerSPTPage> {

  bool timerStatus = false;
  String tooltipMessage = 'start';
  Timer? timer;
  int countDown = 5;

  int reps = 5;
  late int repsLeft = reps;
  int holdsPerRep = 1;
  late int holdsLeft = holdsPerRep;
  int holdTime = 4;
  int downTime = 2;
  Duration restTime = const Duration(minutes: 3);

  _timerButton() {
    if(!timerStatus) {
      timerStatus = true;
      tooltipMessage = 'stop';
      _startSPT();
    } else {
      timerStatus = false;
      tooltipMessage = 'start';
      _stopTimer();
    }
  }

  void _startSPT() {
    setState(() {
      countDown = 5;
      repsLeft = reps;
      holdsLeft = holdsPerRep;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(countDown > 0) {
        setState(() {
          countDown--;
        });
      } else {
        _stopTimer();
        _holdTimer();
      }
    });
  }

  void _stopTimer() {
    timer?.cancel();
  }

  

  void _holdTimer(){
    setState(() {
      countDown = holdTime;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(countDown > 0) {
        setState(() {
          countDown--;
        });
      } else {
        _stopTimer();
        _downTimer();
      }
    });
  }

  void _downTimer() {
    setState(() {
      countDown = downTime;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(countDown > 0) {
        setState(() {
          countDown--;
        });
      } else {
        _stopTimer();
        if(holdsLeft > 0) {
          setState(() {
            holdsLeft--;
          });
          _holdTimer();
        } else {
          _restTimer();
        }
      }
    });
  }

  void _restTimer() {
    setState(() {
      countDown = restTime.inSeconds;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(countDown > 0) {
        setState(() {
          countDown--;
        });
      } else {
        _stopTimer();
        if(repsLeft > 0) {
          setState(() {
            repsLeft--;
          });
          _holdTimer();
        } else {
          // do nothing?
        }
      }
    });
  }

  final listValuesReps = List<int>.generate(20, (i) => i+1, growable: false);
  late final menuEntriesReps = listValuesReps.map((e) => DropdownMenuEntry(value: e, label: e.toString())).toList();

  final listvaluesRestTime = List<Duration>.generate(7, (i) => Duration(seconds: 120+30*i));
  late final menuEntriesRestTime = listvaluesRestTime.map((e) => DropdownMenuEntry(value: e, label: '${e.inMinutes}:${e.inSeconds%60 == 0 ? '00' : '30'}')).toList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Countdown: ' + Duration(seconds: countDown).toString().substring(2, 7),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Holds left: $holdsLeft',
            ),
            Text(
              'Reps left: $repsLeft',
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ElevatedButton(
                onPressed: _timerButton,
                child: Text(tooltipMessage),
                ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: DropdownMenu(
                      label: const Text('Reps'),
                      dropdownMenuEntries: menuEntriesReps,
                      initialSelection: reps,
                      onSelected: (int? selectedReps) {
                        if(selectedReps != null) {
                          setState(() {
                            reps = selectedReps;
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    child: DropdownMenu<Duration>(
                      label: const Text('Resttime'),
                      dropdownMenuEntries: menuEntriesRestTime,
                      initialSelection: restTime,
                      onSelected: (Duration? selectedRestTime) {
                        if(selectedRestTime != null) {
                          setState(() {
                            restTime = selectedRestTime;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'ADD30',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}