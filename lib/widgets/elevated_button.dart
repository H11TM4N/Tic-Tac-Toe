import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Screens/ai_screen.dart';
import 'package:tic_tac_toe/Screens/friend_screen.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                if (text == 'With AI') {
                  return const AIScreen();
                } else {
                  return const FriendScreen();
                }
              },
            ),
          );
        },
        child: Text(text),
      ),
    );
  }
}
