import 'package:flutter/material.dart';

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
          fixedSize: Size(mediaQueryData.size.width * .55, 40),
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
