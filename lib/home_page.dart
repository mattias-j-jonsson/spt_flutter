import 'package:flutter/material.dart';

import 'hold_spt.dart';
import 'power_spt.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // vet fortfarande inte varför detta ska göras

  // final Animation<double> opacityValue = Animation<double>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Image(
          image: AssetImage('assets/archery_female_shadow.png'),
          height: 576,
          width: 576,
          isAntiAlias: false,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const HoldSPTPage(title: 'Holdtitle')));
            },
          child: const Text('hold'),
          ),
        ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const PowerSPTPage(title: 'Powertitle')));
          },
          child: const Text('power')
          ),
      ],
    );
  }
}