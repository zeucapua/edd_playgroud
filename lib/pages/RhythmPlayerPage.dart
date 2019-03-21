import 'package:flutter/material.dart'; import 'package:flutter/services.dart';
import 'dart:async'; import 'package:edd_playgroud/models/Beat.dart';
import 'package:edd_playgroud/widgets/BeatDisplay.dart';
import 'package:edd_playgroud/models/NoteIcons.dart';

class RhythmPlayerPage extends StatefulWidget { @override RhythmPlayerPageState createState() => new RhythmPlayerPageState(); }

class RhythmPlayerPageState extends State<RhythmPlayerPage> {
  //--- INSTANCE VARIABLES ---
  List<Beat> bar; List<BeatDisplay> widgetBar;
  bool isBarPlaying;
  int tempo, timeSignatureTop, timeSignatureBot, currentBeat;
  Timer timer; Duration tempoDuration;


  @override
  void initState() {
    super.initState();

    // init instance variables*
    currentBeat = 0;
    isBarPlaying = false;

    setTempoDuration(168);
    timeSignatureTop = 4; timeSignatureBot = 4;

    bar = List<Beat>();
    bar.add(Beat(4, true)); // quarter
    bar.add(Beat(4, true)); // quarter
    bar.add(Beat(2, true)); // half
    setBeatDurations();

    print(bar);

    widgetBar = List<BeatDisplay>();
    timer = Timer(tempoDuration, () => print('init'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            FlatButton(
              child: Row(
                children: <Widget>[

                  Icon(NoteIcons.quarter, color: Colors.white,),

                  Text(' = ' + tempo.toString())

                ],
              ),
              onPressed: () => showChangeTempo(),
            ),


            // 'bar'
            buildBarWidget()


          ],
        )

      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () => toggleBarPlaying(),
          child: Icon(NoteIcons.quarter),
      ),



    );
  }

  Widget buildBarWidget() {

    //add one BeatDisplay per beat
    widgetBar.clear();
    bar.forEach((beat) => widgetBar.add(BeatDisplay(beat.getValue())));

    print(widgetBar);

    return Row( children: widgetBar );

  }

  void toggleBarPlaying() {
    setBeatDurations();
    if (!isBarPlaying) { isBarPlaying = true; currentBeat = 0; playBar(); }
    else { isBarPlaying = false; timer.cancel(); disableBeatDisplays();  }
    print(isBarPlaying);
  }

  void setTempoDuration(int aTempo) {
    tempo = aTempo;
    tempoDuration = Duration(milliseconds: (60000 / tempo).floor());

    print(tempo.toString() + ' ' + tempoDuration.toString());
  }

  void setBeatDurations() { bar.forEach((beat) => beat.setDuration(tempoDuration, timeSignatureBot)); }

  void showChangeTempo() {

    TextEditingController controller = TextEditingController();
    int toSet = tempo;

    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text('Change tempo'),
          content: Container(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () => Navigator.pop(context)
            )
          ],
        );
      }
    ).then((val) {
      if (controller != null) { toSet = num.parse(controller.text); }
      changeTempo(toSet);
    });

  }

  void changeTempo(int toSet) { setTempoDuration(toSet); setBeatDurations(); }

  void playBar() {
    timer.cancel();

    if (isBarPlaying) {

      //unhighlight all beats
      disableBeatDisplays();

      Beat current = bar.elementAt(currentBeat);

      //highlight beat (placeholder test)
      widgetBar.elementAt(currentBeat).setIsPlaying(true);


      SystemSound.play(SystemSoundType.click);

      currentBeat++; if (currentBeat == bar.length) { currentBeat = 0; }
      timer = Timer(current.getDuration(), () => playBar());
    }
  }

  void disableBeatDisplays() { widgetBar.forEach((display) => display.setIsPlaying(false)); }

}