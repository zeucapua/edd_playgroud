import 'package:flutter/material.dart';
import 'dart:io'; import 'dart:async'; import 'package:flutter/services.dart';

class MetronomePage extends StatefulWidget { @override MetronomePageState createState() => MetronomePageState(); }

class MetronomePageState extends State<MetronomePage> {
  //--- INSTANCE VARIABLES ---
  int beatsPerMinute; Duration duration;
  Timer metronome; int minuteInMilliseconds = 60000; int currentBeat;
  bool onAccentBeat1, onAccentBeat2, onAccentBeat3, onAccentBeat4, isMetronomeOn;
  TextEditingController bpmTextController;

  @override
  void initState() {
    //-- INITIALIZE --
    super.initState();
    currentBeat = 0;
    beatsPerMinute = 60;
    updateDuration(beatsPerMinute);
    isMetronomeOn = false; turnOffAccentWidgets();
    bpmTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            // Accent Beats
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                    opacity: onAccentBeat1 ? 1.0 : 0.35,
                    duration: duration ~/ 2,
                    child: Container(
                      width: 100.0, height: 100.0,
                      color: ThemeData.dark().accentColor,
                    )
                ),
                AnimatedOpacity(
                    opacity: onAccentBeat2 ? 1.0 : 0.35,
                    duration: duration ~/ 2,
                    child: Container(
                      width: 100.0, height: 100.0,
                      color: ThemeData.dark().accentColor,
                    )
                ),
                AnimatedOpacity(
                    opacity: onAccentBeat3 ? 1.0 : 0.35,
                    duration: duration ~/ 2,
                    child: Container(
                      width: 100.0, height: 100.0,
                      color: ThemeData.dark().accentColor,
                    )
                ),
                AnimatedOpacity(
                    opacity: onAccentBeat4 ? 1.0 : 0.35,
                    duration: duration ~/ 2,
                    child: Container(
                      width: 100.0, height: 100.0,
                      color: ThemeData.dark().accentColor,
                    )
                )
              ],
            ),


            // Input Widgets
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextField(controller: bpmTextController,),
                ),

                RaisedButton(onPressed: () => updateDuration(int.parse(bpmTextController.text)), child: Text('UDPATE BPM'),)
              ],
            )

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () => updateMetronome(), child: !isMetronomeOn ? Icon(Icons.play_arrow) : Icon(Icons.stop)),
    );
  }

  //--- METHODS ---
  void updateDuration(int newBeatsPerMinute) {
    beatsPerMinute = newBeatsPerMinute;
    duration = Duration(milliseconds: (minuteInMilliseconds / beatsPerMinute).floor());
  }

  void updateMetronome() {
    if (!isMetronomeOn) {
      setState(() {
        currentBeat = 1; isMetronomeOn = true;
        print(isMetronomeOn);
        metronome = new Timer.periodic(duration, (data) => playMetronome() );
      });
    } else {
      setState(() {
        currentBeat = 0; isMetronomeOn = false;
        print(isMetronomeOn);
        metronome.cancel(); turnOffAccentWidgets();
      });
    }

  }

  void playMetronome() async {

    SystemSound.play(SystemSoundType.click);

    setState(() {
      turnOffAccentWidgets();

      switch(currentBeat) {
        case 1: onAccentBeat1 = true; break;
        case 2: onAccentBeat2 = true; break;
        case 3: onAccentBeat3 = true; break;
        case 4: onAccentBeat4 = true; break;
      }

      if (currentBeat != 0) { currentBeat++; if (currentBeat == 5) { currentBeat = 1; } }
    });
  }

  void turnOffAccentWidgets() { onAccentBeat1 = false; onAccentBeat2 = false; onAccentBeat3 = false; onAccentBeat4 = false;}
}