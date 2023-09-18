import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/with_AI/ai_screen.dart';
import 'package:tic_tac_toe/screens/with_a_friend/friend_screen.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;

  const MyElevatedButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(mediaQueryData.size.width * .65, 40),
        ),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                if (text == 'With AI') {
                  return const AIScreen();
                } else {
                  return const FriendScreen();
                }
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Text(text),
      ),
    );
  }
}
