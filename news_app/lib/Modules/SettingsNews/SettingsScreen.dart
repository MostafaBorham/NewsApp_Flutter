// ignore_for_file: file_names
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontSize: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}
