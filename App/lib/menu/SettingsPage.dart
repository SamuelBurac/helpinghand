import 'package:flutter/material.dart';
import 'package:helping_hand/services/NotificationsProvider.dart';
import 'package:helping_hand/services/ThemeProvider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _buildFrequencyRadioTile(
    BuildContext context,
    String title,
    NotificationFrequency value,
    NotificationFrequency groupValue,
    Function(NotificationFrequency?) onChanged,
  ) {
    return RadioListTile<NotificationFrequency>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }

  Widget _buildNotificationSection(
    BuildContext context,
    String title,
    NotificationFrequency currentFrequency,
    Function(NotificationFrequency) onFrequencyChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildFrequencyRadioTile(
          context,
          'Immediately',
          NotificationFrequency.immediate,
          currentFrequency,
          (value) => onFrequencyChanged(value!),
        ),
        _buildFrequencyRadioTile(
          context,
          'Once Daily',
          NotificationFrequency.daily,
          currentFrequency,
          (value) => onFrequencyChanged(value!),
        ),
        _buildFrequencyRadioTile(
          context,
          'Disabled',
          NotificationFrequency.disabled,
          currentFrequency,
          (value) => onFrequencyChanged(value!),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          // Theme Settings Section
          Card(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Appearance',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) => Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        title: const Text('Light Mode'),
                        value: ThemeMode.light,
                        groupValue: themeProvider.themeMode,
                        onChanged: (ThemeMode? value) {
                          themeProvider.setThemeMode(value!);
                        },
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Dark Mode'),
                        value: ThemeMode.dark,
                        groupValue: themeProvider.themeMode,
                        onChanged: (ThemeMode? value) {
                          themeProvider.setThemeMode(value!);
                        },
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('System Default'),
                        value: ThemeMode.system,
                        groupValue: themeProvider.themeMode,
                        onChanged: (ThemeMode? value) {
                          themeProvider.setThemeMode(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Account Settings Section
          Card(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: const Text('Account Information'),
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to your account info screen
                Navigator.pushNamed(context, '/accountDetails');
              },
            ),
          ),

          const SizedBox(height: 16),

          // Notifications Card
          Card(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<NotificationPreferences>(
              builder: (context, notifPrefs, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // In-App Messages Switch
                  SwitchListTile(
                    title: const Text('In-App Messages'),
                    subtitle:
                        const Text('Receive messages while using the app'),
                    value: notifPrefs.inAppMessages,
                    onChanged: (bool value) {
                      notifPrefs.setInAppMessages(value);
                    },
                  ),
                  const Divider(),

                  // // New Job Notifications
                  // _buildNotificationSection(
                  //   context,
                  //   'New Job Notifications',
                  //   notifPrefs.newJobFrequency,
                  //   (freq) => notifPrefs.setNewJobFrequency(freq),
                  // ),

                  // // New Available Person Notifications
                  // _buildNotificationSection(
                  //   context,
                  //   'New Available Person Notifications',
                  //   notifPrefs.newPersonFrequency,
                  //   (freq) => notifPrefs.setNewPersonFrequency(freq),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
