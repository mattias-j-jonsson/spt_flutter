import 'package:flutter/material.dart';
import 'dart:async';


class HoldSPTPage extends StatefulWidget {
  const HoldSPTPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  
  @override
  State<HoldSPTPage> createState() => _HoldSPTPageState();
}

class _HoldSPTPageState extends State<HoldSPTPage> {
  // static varibled to rember menu choices
  // is updated in dispose()
  static int sHoldStateData = 10;
  static int sRepsStateData = 2;



  // AUDIOPLAYER CODE
  // final AudioPlayer player = AudioPlayer();
  // final soundPath = 
  //           '382765__miradeshazer__countdown-1-to-10-and-10-to-zero-female.mp3';


  String tooltipMessage = 'start';
  String timeString = '00:00';
  bool timerStatus = false;
  Timer? timer;

  void _timerButton() {
    if(!timerStatus) {
      timerStatus = true;
      tooltipMessage = 'stop';
      _startTimer();
    } else {
      timerStatus = false;
      tooltipMessage = 'start';
      _stopTimer();
    }
  }

  void _startTimer() {
    setState(() {
      countdown = 3;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        _stopTimer();
        _countdownSPT(seconds: startValue, reps: noOfReps-1, isHold: true);
      }
    });
  }

  void _stopTimer() {
    countdown = startValue;
    timer?.cancel();
    setState(() {
      
    });
  }

  int startValue = sHoldStateData;
  late int countdown = startValue;
  int noOfReps = sRepsStateData;
  late int repsLeft = noOfReps;


  void _countdownSPT ({required seconds, 
                      required int reps, required bool isHold}) {
    setState(() {
      countdown = seconds;
      repsLeft = reps;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(countdown > 0) {
        // if(countdown <= 4) {
        //   SystemSound.play(SystemSoundType.alert);
        // }
        setState(() {
          countdown--;
        });
      } else {
        _stopTimer();
        if(isHold){
          _countdownSPT(seconds: 2*startValue, reps: reps, isHold: false);
        } else if(reps > 0) {
          reps--;
          _countdownSPT(seconds: startValue, reps: reps, isHold: true);
        } else { // Cleanup on exit final rep.
          tooltipMessage = 'start';
          timerStatus = false;
        }
      }
    });
  }


  final listValuesHold = <int>[2, 5, 10, 15, 20, 30, 45]; // 2 included for debugging

  late final menuEntriesHold = listValuesHold.map((e) => DropdownMenuEntry(value: e, label: e.toString())).toList();

  final listValuesReps = List<int>.generate(60, (int index) => index+1, growable: false);

  late final menuEntriesReps = listValuesReps.map((e) => DropdownMenuEntry(value: e, label: e.toString())).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                Duration(seconds: countdown).toString().substring(2, 7),
                textAlign: TextAlign.center,
                // style: Theme.of(context).textTheme.headlineLarge,
                style: const TextStyle(fontSize: 72.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Text(
                'Repetitions left: $repsLeft',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownMenu(
                  label: const Text('Hold'),
                  dropdownMenuEntries: menuEntriesHold,
                  enabled: !timerStatus,
                  onSelected: (int? selectedHold) {
                      if(selectedHold != null){
                      setState(() {
                        startValue = selectedHold;
                      });
                    }
                  },
                  initialSelection: startValue,
                ),
                DropdownMenu(
                  label: const Text('Reps'),
                  dropdownMenuEntries: menuEntriesReps,
                  enabled: !timerStatus,
                  onSelected: (int? selectedReps) {
                    if(selectedReps != null){
                      setState(() {
                        noOfReps = selectedReps;
                      });
                    }
                  },
                  initialSelection: noOfReps,
                )
              ]
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: FloatingActionButton(
                onPressed: _timerButton,
                tooltip: tooltipMessage,
                backgroundColor: const Color.fromARGB(255, 32, 175, 241),
                child: Text(tooltipMessage),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _timerButton,
      //   tooltip: tooltipMessage,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    sHoldStateData = startValue;
    sRepsStateData = noOfReps;
  }
}