import 'package:flutter/material.dart';

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
          IconData(0xe900, fontFamily: 'whole'),
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      case 2:
        _icon = Icon(
          IconData(0xe900, fontFamily: 'half'),
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      case 4:
        _icon = Icon(
          IconData(0xe900, fontFamily: 'quarter'),
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      case 8:
        _icon = Icon(
          IconData(0xe900, fontFamily: 'eighth'),
          color: _isPlaying ? Colors.white : Colors.black,
          size: 50.0,
        ); break;
      default:
        _icon = Icon(
          IconData(0xe900, fontFamily: 'whole'),
          color: _isPlaying ? Colors.white : Colors.black,
        ); break;
    }

    return Container( child: _icon );

  }

  void setIsPlaying(bool toSet) { setState(() { _isPlaying = toSet; }); }

}