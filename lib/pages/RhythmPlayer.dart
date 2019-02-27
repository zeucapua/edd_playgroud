import 'package:flutter/material.dart'; import 'package:flutter/services.dart';
import 'dart:async'; import 'package:edd_playgroud/models/Beat.dart';
import 'package:edd_playgroud/widgets/BeatDisplay.dart';


class RhythmPlayerPage extends StatefulWidget { @override RhythmPlayerPageState createState() => new RhythmPlayerPageState(); }

class RhythmPlayerPageState extends State<RhythmPlayerPage> {
  //--- INSTANCE VARIABLES ---
  List<Beat> bar; List<BeatDisplay> widgetBar;
  bool isBarPlaying, isBeatPlaying;
  int tempo, timeSignatureTop, timeSignatureBot, currentBeat;
  Timer timer; Duration tempoDuration, beatDuration;


  @override
  void initState() {
    super.initState();

    // init instance variables*
    currentBeat = 0;
    isBarPlaying = false; isBeatPlaying = false;

    tempo = 120; setTempoDuration();
    timeSignatureTop = 4; timeSignatureBot = 4;

    bar = List<Beat>();
    bar.add(Beat(4, 0, true)); // quarter
    bar.add(Beat(4, 1, true)); // quarter
    bar.add(Beat(2, 2, true)); // half
    setBeatDurations(); beatDuration = bar.elementAt(0).getDuration();

    print(bar);

    widgetBar = List<BeatDisplay>();
    timer = Timer(tempoDuration, () => print('init'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: buildBarWidget()

      ),

      floatingActionButton: FloatingActionButton(onPressed: () => toggleBarPlaying()),


    );
  }

  void toggleBarPlaying() {
    if (!isBarPlaying) { isBarPlaying = true; currentBeat = 0; playBar(); }
    else { isBarPlaying = false; timer.cancel(); widgetBar.forEach((display) => display.setIsPlaying(false)); }
    print(isBarPlaying);
  }

  void setTempoDuration() { tempoDuration = Duration(milliseconds: (60000 / tempo).floor()); }

  void setBeatDurations() { bar.forEach((beat) => beat.setDuration(tempoDuration, timeSignatureBot)); }

  //TODO: HIGHLIGHT AND UNHIGHLIGHT BEATDISPLAYS
  void playBar() {
    timer.cancel();

    if (isBarPlaying) {

      //unhighlight all beats
      widgetBar.forEach((display) => display.setIsPlaying(false));

      Beat current = bar.elementAt(currentBeat);

      //highlight beat (placeholder test)
      widgetBar.elementAt(currentBeat).setIsPlaying(true);


      SystemSound.play(SystemSoundType.click);

      currentBeat++; if (currentBeat == bar.length) { currentBeat = 0; }
      timer = Timer(current.getDuration(), () => playBar());
    }
  }

  //TODO: FIX ROW OF BEATDISPLAYS
  Widget buildBarWidget() {

    //add one BeatDisplay per beat
    widgetBar.clear();
    bar.forEach((beat) => widgetBar.add(BeatDisplay(beat.getValue(), beat.getKey(), false)));

    print(widgetBar);

    return Row( children: widgetBar );

  }

}