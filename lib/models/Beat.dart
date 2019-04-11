class Beat {
  int _value; // 1: whole, 2: half, 4: quarter, 8: eighth; TODO: Add more corresponding values
  Duration _duration; // how long is this beat going to last;
  bool isBeat; // determine whether or not to play sound if 'played'
  int _note; // see Scratch chart for midi note values
  //TODO: Add pitch/sound value (String for asset/ num for pitch emulation???)

  Beat(this._value, this.isBeat) { _duration = Duration(milliseconds: 0); _note = 60; }

  void setDuration(Duration tempoDuration, int timeSignatureBot) {
    if (timeSignatureBot == 4) {
      switch (_value) {
        case 1: _duration = tempoDuration * 4; break;
        case 2: _duration = tempoDuration * 2; break;
        case 4: _duration = tempoDuration;     break;
        case 8: _duration = tempoDuration ~/ 2; break;
        default: print("Invalid Value");       break;
      }
    } else if (timeSignatureBot == 8) {
      switch (_value) {
        case 1: _duration = tempoDuration * 8; break;
        case 2: _duration = tempoDuration * 4; break;
        case 4: _duration = tempoDuration * 2; break;
        case 8: _duration = tempoDuration;     break;
        default: print("Invalid Value");       break;
      }
    }
  }

  Duration getDuration() { return _duration; }
  int getValue() { return _value; }
  int getNote() { return _note; }
}