import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Add notification logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const NotificationSection(
              sectionTitle: 'Today',
              notifications: [
                NotificationItem(
                  icon: Icons.notifications,
                  title: 'Reminder!',
                  subtitle:
                      'Set up your automatic savings to meet your savings goal...',
                  time: '17:00 - April 24',
                ),
                NotificationItem(
                  icon: Icons.update,
                  title: 'New Update',
                  subtitle:
                      'Set up your automatic savings to meet your savings goal...',
                  time: '17:00 - April 24',
                ),
              ],
            ),
            const NotificationSection(
              sectionTitle: 'Yesterday',
              notifications: [
                NotificationItem(
                  icon: Icons.attach_money,
                  title: 'Transactions',
                  subtitle: 'A new transaction has been registered',
                  details: 'Groceries | Pantry | -\$100.00',
                  time: '17:00 - April 24',
                ),
                NotificationItem(
                  icon: Icons.notifications,
                  title: 'Reminder!',
                  subtitle:
                      'Set up your automatic savings to meet your savings goal...',
                  time: '17:00 - April 24',
                ),
              ],
            ),
            const NotificationSection(
              sectionTitle: 'This Weekend',
              notifications: [
                NotificationItem(
                  icon: Icons.receipt,
                  title: 'Expense Record',
                  subtitle:
                      'We recommend that you be more attentive to your finances.',
                  time: '17:00 - April 24',
                ),
                NotificationItem(
                  icon: Icons.attach_money,
                  title: 'Transactions',
                  subtitle: 'A new transaction has been registered',
                  details: 'Food | Dinner | -\$70.40',
                  time: '17:00 - April 24',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String sectionTitle;
  final List<NotificationItem> notifications;

  const NotificationSection({
    required this.sectionTitle,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: notifications.map((item) => item).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final String? details;

  const NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: Colors.purple),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          if (details != null)
            Text(
              details!,
              style: const TextStyle(color: Colors.blue),
            ),
        ],
      ),
      trailing: Text(time),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
