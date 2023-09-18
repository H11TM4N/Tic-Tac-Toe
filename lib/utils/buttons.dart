import 'package:flutter/material.dart';

IconButton homeButton(BuildContext context) => IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.home_sharp,
        size: 50,
        color: Colors.blueGrey,
      ),
    );

IconButton refreshButton() => IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.refresh,
        size: 50,
        color: Colors.blueGrey,
      ),
    );
