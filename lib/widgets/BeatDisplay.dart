import 'package:flutter/material.dart';

class BeatDisplay extends StatefulWidget {

  BeatDisplayState state;

  BeatDisplay(int value, int key, bool isPlaying) { state = BeatDisplayState(value, key, isPlaying); }

  void setIsPlaying(bool toSet) { state.setIsPlaying(toSet); }
  int  getKey() { return state.getKey(); }

  @override BeatDisplayState createState() => state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return state._value.toString() + ' ' +
        state._key.toString() + ' ' +
        state._isPlaying.toString();
  }
}

class BeatDisplayState extends State<BeatDisplay> {
  //--- INSTANCE VARIABLE ---
  int _value, _key; Color _boxColor; bool _isPlaying;

  BeatDisplayState(this._value, this._key, this._isPlaying);

  @override
  Widget build(BuildContext context) {

    switch (_value) {
      case 1: _boxColor = Color.fromRGBO(218, 62, 82, 1.0); break;
      case 2: _boxColor = Color.fromRGBO(242, 233, 78, 1.0); break;
      case 4: _boxColor = Color.fromRGBO(150, 230, 179, 1.0); break;
      case 8: _boxColor = Color.fromRGBO(163, 217, 255, 1.0); break;
      default: _boxColor = Color.fromRGBO(228, 253, 225, 1.0); break;
    }

    return AnimatedOpacity(
      opacity: _isPlaying ? 1.0 : 0.5,
      duration: Duration(milliseconds: 250),
      child: Container(
        width: 100.0, height: 100.0,
        color: _boxColor,
      )
    );

  }

  void setIsPlaying(bool toSet) { setState(() { _isPlaying = toSet; }); }
  int  getKey() { return _key; }

}