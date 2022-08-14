import 'package:flutter/material.dart';

import '../../widget/progress/advanced/advanced_progress.dart';

class SelectionProgress extends StatelessWidget {
  final int progress;

  const SelectionProgress({Key? key, this.progress = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 7,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: progressContainer(),
      ),
    );
  }

  Widget progressContainer() {
    return AdvancedProgress(
      radius: 120,
      levelAmount: 76,
      levelLowHeight: 16,
      levelHighHeight: 20,
      division: 15,
      secondaryWidth: 8,
      progressGap: 12,
      primaryValue: 0.50,
      secondaryValue: 0.75,
      primaryColor: Colors.yellow,
      secondaryColor: Colors.red,
      tertiaryColor: Colors.black12,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(
                top: 16.0,
              ),
              child: Text(
                ' 240°',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w400,
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 16.0,
              ),
              child: Text(
                'PREHEATING',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 3.0,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w800,
                  fontSize: 8,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '35:00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Barlow',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white24,
                    ),
                  ),
                  Text(
                    'Time left',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      fontFamily: 'Barlow',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.white24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}