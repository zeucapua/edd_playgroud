class Beat {
  int _value; // 1: whole, 2: half, 4: quarter, 8: eighth; TODO: Add more corresponding values
  int _duration; // how long is this beat going to last;
  bool isBeat; // determine whether or not to play sound if 'played'
  //TODO: Add pitch/sound value (String for asset/ num for pitch emulation???)

  Beat(this._value, this.isBeat) { _duration = 0; }

  void assignDuration(int tempoDuration, int timeSignatureDenominator) {
    if (timeSignatureDenominator == 4) {
      switch (_value) {
        case 1: _duration = tempoDuration * 4; break;
        case 2: _duration = tempoDuration * 2; break;
        case 4: _duration = tempoDuration;     break;
        case 8: _duration = (tempoDuration / 2).floor(); break;
        default: print("Invalid Value");       break;
      }
    } else if (timeSignatureDenominator == 8) {
      switch (_value) {
        case 1: _duration = tempoDuration * 8; break;
        case 2: _duration = tempoDuration * 4; break;
        case 4: _duration = tempoDuration * 2; break;
        case 8: _duration = tempoDuration;     break;
        default: print("Invalid Value");       break;
      }
    }
  }

  int getDuration() { return _duration; } int getValue() { return _value; }
}