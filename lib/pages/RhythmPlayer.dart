import 'package:flutter/material.dart'; import 'package:flutter/services.dart';
import 'dart:async'; import 'package:edd_playgroud/models/Beat.dart';

class RhythmPlayer extends StatefulWidget { @override RhythmPlayerState createState() => new RhythmPlayerState(); }

class RhythmPlayerState extends State<RhythmPlayer> {
  //--- INSTANCE VARIABLES ---
  List<Beat> bar; int timeSignatureNumerator, timeSignatureDenominator;
  int tempo, tempoDuration, currentBeat; Timer metronome; bool barPlaying;
  Color boxColor; bool isBeatPlaying; Duration beatRecedeDuration;

  //--- constants ---
  static const int MINUTE_MILLISECONDS = 60000;

  @override
  void initState() {
    super.initState();

    // set tempo and time signature
    timeSignatureNumerator = 4; timeSignatureDenominator = 4;
    tempo = 120; setTempoDuration();

    // set bar and beats
    bar = new List<Beat>();
    for (var i = 0; i < timeSignatureNumerator; i++) { bar.add(new Beat(4, true)); } // placeholder
    setBeatDurations(); currentBeat = 0; barPlaying = false; beatRecedeDuration = Duration(milliseconds: 1); // placeholder

    // set timer (placeholder)
    metronome = new Timer(Duration(milliseconds: tempoDuration), () => print('hi'));

    // set widget instances
    boxColor = ThemeData.dark().accentColor; // accent color if quarter
    isBeatPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: isBeatPlaying ? 1.0 : 0.25,
          duration: beatRecedeDuration,
          child: Container(
            width: 100.0, height: 100.0,
            color: boxColor,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => updateMetronome()),
    );
  }

  void setTempoDuration() { tempoDuration = (MINUTE_MILLISECONDS / tempo).floor(); }

  void setBeatDurations() { bar.forEach((beat) => beat.assignDuration(tempoDuration, timeSignatureDenominator)); }

  void updateMetronome() {
    /** Go through each beat in array 'bar' by 'playing' each beat and then setting a timer to play the next one **/
    if (!barPlaying) { barPlaying = true; print(barPlaying); playBeat(); }
    else { barPlaying = false; print(barPlaying); metronome.cancel(); setState(() { isBeatPlaying = false; });}
  }

  void playBeat() {
    Beat beat = bar.elementAt(currentBeat);
    Duration halfBeatDuration = Duration(milliseconds: (beat.getDuration() / 2).floor());
    setState(() {
      switch (beat.getValue()) {
        case 4: boxColor = ThemeData.dark().accentColor; break;
        case 1: boxColor = ThemeData.dark().bottomAppBarColor; break;
        default: boxColor = ThemeData.dark().canvasColor; break;
      }
      if (beat.isBeat) {
        SystemSound.play(SystemSoundType.click);
        toggleBeatPlayingBool();
      }
      metronome = Timer(halfBeatDuration, () => toggleBeatPlayingBool());
    });

    metronome.cancel();

    currentBeat++; if (currentBeat == bar.length) { currentBeat = 0; }
    metronome = Timer(halfBeatDuration, () => playBeat());
  }

  void toggleBeatPlayingBool() { isBeatPlaying = isBeatPlaying ? false : true; }
}