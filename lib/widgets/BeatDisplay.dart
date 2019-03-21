import 'package:flutter/material.dart';
import 'package:edd_playgroud/models/NoteIcons.dart';


class BeatDisplay extends StatefulWidget {

  BeatDisplayState state;

  BeatDisplay(int value) { state = BeatDisplayState(value, false); }

  void setIsPlaying(bool toSet) { state.setIsPlaying(toSet); }

  @override BeatDisplayState createState() => state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return state._value.toString() + ' ' +
        state._isPlaying.toString();
  }
}

class BeatDisplayState extends State<BeatDisplay> {
  //--- INSTANCE VARIABLE ---
  int _value; bool _isPlaying; Icon _icon;

  BeatDisplayState(this._value, this._isPlaying);

  @override
  Widget build(BuildContext context) {

    switch (_value) {
      case 1:
        _icon = Icon(
          NoteIcons.whole,
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      case 2:
        _icon = Icon(
          NoteIcons.half,
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      case 4:
        _icon = Icon(
          NoteIcons.quarter,
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      case 8:
        _icon = Icon(
          NoteIcons.eighth,
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      default:
        _icon = Icon(
          NoteIcons.sixteenth,
          color: _isPlaying ? Colors.white : Colors.black,
        ); break;
    }

    return Container( child: _icon );

  }

  void setIsPlaying(bool toSet) { setState(() { _isPlaying = toSet; }); }

}