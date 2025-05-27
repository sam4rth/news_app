import 'package:news_app/providers/darkmode_provider.dart';
import 'package:news_app/providers/ishort_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  static String _selectedReadStatus = 'All'; // Default value
  //static bool isShortArticlesOnly = false; // Default value
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final darkmodeProvider = Provider.of<DarkmodeProvider>(context);
    final isShortArticlesOnly = Provider.of<IshortProvider>(context); // Accessing the static variable directly
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Dark Mode Switch
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
          //Short articles Switch
          SwitchListTile(
            activeColor: Colors.white,
            hoverColor: Colors.white,
            activeTrackColor: Colors.blueAccent,
            title: const Text('Short Articles Only'),
            value: isShortArticlesOnly.isShort, // Accessing the static variable directly
            onChanged: (value) {
              isShortArticlesOnly.toggleIsShort(value);
            },
          ),
          //Read not read dropdown
          ListTile(
            title: const Text('Read/Unread Articles (TODO)'),
            trailing: DropdownButton<String>(
              value: SettingsScreen._selectedReadStatus,
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Read', child: Text('Read')),
                DropdownMenuItem(value: 'Unread', child: Text('Unread')),
              ],
              onChanged: (value) { // Default to 'All' if null
                setState((){                  
                SettingsScreen._selectedReadStatus = value ?? 'All';
                //print('Selected: ${SettingsScreen._selectedReadStatus}');
                });

              },
            ),
          ),
        ],
      ),
    );
  }
}
