import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class ScoreContainer extends StatelessWidget {
  final String title;
  final int score;
  final Color color;
  const ScoreContainer({
    super.key,
    required this.title,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 96 / 64,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                title,
                height: 0,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: appColors.darkNavy,
              ),
              // YBox(5),
              AppText(
                score.toString(),
                fontSize: 24,
                height: 0,
                fontWeight: FontWeight.w700,
                color: appColors.darkNavy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
