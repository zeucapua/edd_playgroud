import 'package:flutter/material.dart'; import 'package:flutter/services.dart';
import 'dart:async'; import 'package:edd_playgroud/models/Beat.dart';

class RhythmPlayerPage extends StatefulWidget { @override RhythmPlayerPageState createState() => new RhythmPlayerPageState(); }

class RhythmPlayerPageState extends State<RhythmPlayerPage> {
  //--- INSTANCE VARIABLES ---
  List<Beat> bar; bool isBarPlaying, isBeatPlaying;
  int tempo, timeSignatureTop, timeSignatureBot, currentBeat;
  Timer timer; Duration tempoDuration, beatDuration;

  String toDisplay;

  @override
  void initState() {
    super.initState();

    // init instance variables*
    currentBeat = 0;
    isBarPlaying = false; isBeatPlaying = false;

    tempo = 120; setTempoDuration();
    timeSignatureTop = 4; timeSignatureBot = 4;

    bar = List<Beat>();
    bar.add(Beat(4, true, '1')); // quarter
    bar.add(Beat(4, true, '2')); // quarter
    bar.add(Beat(2, true, '3')); // half
    setBeatDurations(); beatDuration = bar.elementAt(0).getDuration();

    toDisplay = bar.elementAt(currentBeat).display;

    timer = Timer(tempoDuration, () => print('init'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Text(toDisplay)

      ),

      floatingActionButton: FloatingActionButton(onPressed: () => toggleBarPlaying()),


    );
  }

  void toggleBarPlaying() {
    if (!isBarPlaying) { isBarPlaying = true; currentBeat = 0; playBar(); }
    else { isBarPlaying = false; timer.cancel(); }
  }

  void setTempoDuration() { tempoDuration = Duration(milliseconds: (60000 / tempo).floor()); }

  void setBeatDurations() { bar.forEach((beat) => beat.setDuration(tempoDuration, timeSignatureBot)); }

  void playBar() {
    timer.cancel();

    if (isBarPlaying) {
      Beat current = bar.elementAt(currentBeat);

      setState(() { toDisplay = current.display; });

      SystemSound.play(SystemSoundType.click);

      currentBeat++; if (currentBeat == bar.length) { currentBeat = 0; }
      timer = Timer(current.getDuration(), () => playBar());
    }
  }

}