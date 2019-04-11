import 'package:flutter/material.dart';
import 'dart:async'; import 'package:flutter/services.dart';
import 'package:edd_playgroud/models/Beat.dart';
import 'package:edd_playgroud/widgets/BeatDisplay.dart';

class MetronomePage extends StatefulWidget { @override MetronomePageState createState() => MetronomePageState(); }

class MetronomePageState extends State<MetronomePage> {

  //--- INSTANCE VARIABLES ---
  List<Beat> bar; List<BeatDisplay> widgetBar;
  bool isMetronomePlaying;
  int tempo, timeSignatureTop, timeSignatureBot, currentBeat;
  static const int MINUTE_IN_MILLISECONDS = 60000;
  Timer timer; Duration tempoDuration;

  @override
  void initState() {
    super.initState();

    // init bar as 4/4
    timeSignatureTop = 4; timeSignatureBot = 4;

    bar = List<Beat>();
    for (int i = 0; i < timeSignatureTop; i++) { bar.add(Beat(timeSignatureBot, true)); }

    // set tempo and metronome
    setTempoDuration(120);
    timer = Timer(tempoDuration, () => print('init'));

    // init misc.
    currentBeat = 0; isMetronomePlaying = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            buildBarWidget(),

            //TODO: add ChangeTempo function and dialog from RhythmPlayerPage

            RaisedButton(
              onPressed: () => toggleMetronome(),
              child: isMetronomePlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
            )

          ],
        )
      ),

    );

  }

  void setTempoDuration(int beatsPerMinute) {
    tempo = beatsPerMinute;
    tempoDuration = Duration(milliseconds: (MINUTE_IN_MILLISECONDS/tempo).floor());
  }

  Widget buildBarWidget() {

    widgetBar = List<BeatDisplay>();

    widgetBar.clear();
    bar.forEach((beat) => widgetBar.add(BeatDisplay(beat.getValue())));

    return Row(children: widgetBar);

  }

  void disableBarWidget() { widgetBar.forEach((display) => display.setIsPlaying(false)); }

  void toggleMetronome() {
    // toggle
    isMetronomePlaying = isMetronomePlaying ? false : true;

    // reset metronome
    timer.cancel();
    currentBeat = 0;

    playBar();
  }

  void playBar() {
    disableBarWidget();

    if (isMetronomePlaying) {

      // highlight current BeatDisplay
      widgetBar.elementAt(currentBeat).setIsPlaying(true);

      SystemSound.play(SystemSoundType.click);

      currentBeat++; if (currentBeat == timeSignatureTop) { currentBeat = 0; }
      timer = Timer(tempoDuration, () => playBar());
    }
  }
}