import 'package:flutter/material.dart';

import 'package:edd_playgroud/pages/MetronomePage.dart';
import 'package:edd_playgroud/pages/RhythmPlayerPage.dart';

void main() => runApp(EDDPlaygroundApp());

class EDDPlaygroundApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDD Playground',
      theme: ThemeData.dark(),
      home: RhythmPlayerPage()
    );
  }


}