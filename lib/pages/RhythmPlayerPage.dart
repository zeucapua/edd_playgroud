import 'package:flutter/material.dart'; import 'package:flutter/services.dart';
import 'dart:async'; import 'package:edd_playgroud/models/Beat.dart';
import 'package:edd_playgroud/widgets/BeatDisplay.dart';


class RhythmPlayerPage extends StatefulWidget { @override RhythmPlayerPageState createState() => new RhythmPlayerPageState(); }

class RhythmPlayerPageState extends State<RhythmPlayerPage> {
  //--- INSTANCE VARIABLES ---
  List<Beat> bar; List<BeatDisplay> widgetBar;
  bool isBarPlaying;
  int tempo, timeSignatureTop, timeSignatureBot, currentBeat;
  Timer timer; Duration tempoDuration;

  final _tempoTextController = TextEditingController(); 

  @override
  void initState() {
    super.initState();

    // init instance variables*
    currentBeat = 0;
    isBarPlaying = false;

    tempo = 168; setTempoDuration();
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

            // tempo
            FlatButton(
              child: Row(
                children: <Widget>[

                  Icon(IconData(0xe900, fontFamily: 'quarter'), color: Colors.white,),

                  Text(' = ' + tempo.toString())

                ],
              ),
              onPressed: () => changeTempo() ,
            ),

            // 'bar'
            buildBarWidget()


          ],
        )

      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () => toggleBarPlaying(),
          child: Icon(IconData(0xe900, fontFamily: 'quarter'), color: Colors.white,),
      ),



    );
  }

  void toggleBarPlaying() {
    if (!isBarPlaying) { isBarPlaying = true; currentBeat = 0; playBar(); }
    else { isBarPlaying = false; timer.cancel(); disableBeatDisplays();  }
    print(isBarPlaying);
  }

  void setTempoDuration() { tempoDuration = Duration(milliseconds: (60000 / tempo).floor()); }

  void setBeatDurations() { bar.forEach((beat) => beat.setDuration(tempoDuration, timeSignatureBot)); }

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

  Widget buildBarWidget() {

    //add one BeatDisplay per beat
    widgetBar.clear();
    bar.forEach((beat) => widgetBar.add(BeatDisplay(beat.getValue())));

    print(widgetBar);

    return Row( children: widgetBar );

  }

  void disableBeatDisplays() { widgetBar.forEach((display) => display.setIsPlaying(false)); }

  void changeTempo() {

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {

        return Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              TextField(controller: _tempoTextController,),
              FlatButton(onPressed: () => {}, child: Icon(Icons.check))

            ],
          ),
        );

      }
    ).whenComplete( () {
      if (mounted) { setState(() {
        tempo = int.parse(_tempoTextController.toString());
        print(tempo);
      }); }
    });


  }
}