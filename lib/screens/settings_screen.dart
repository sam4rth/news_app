import 'package:news_app/providers/darkmode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkmodeProvider = Provider.of<DarkmodeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            activeColor: Colors.white,
            hoverColor: Colors.white,
            activeTrackColor: Colors.blueAccent,
            title: const Text('Dark Mode'),
            value: darkmodeProvider.isDarkMode,
            onChanged: (value) {
              darkmodeProvider.toggleDM(value);
            },
          ),
        ],
      ),
    );
  }
}
