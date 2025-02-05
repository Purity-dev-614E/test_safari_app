import 'package:flutter/material.dart';


class userDashboard extends StatelessWidget {
  const userDashboard({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/Profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard("Total Members", "120"),
                _buildSummaryCard("Next Event", "Sunday Service"),
              ],
            ),

            const SizedBox(height: 20),

            // Upcoming Events List
            Expanded(
              child: ListView(
                children: [
                  _buildEventCard(
                      "Sunday Service", "Feb 11, 10:00 AM", "Main Church"),
                  _buildEventCard(
                      "Bible Study", "Feb 14, 6:00 PM", "Youth Hall"),
                  _buildEventCard(
                      "Community Outreach", "Feb 17, 9:00 AM", "Town Center"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Card Widget
  Widget _buildSummaryCard(String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Event Card Widget
  Widget _buildEventCard(String eventName, String dateTime, String location) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(eventName, style: const TextStyle(fontWeight: FontWeight
            .bold)),
        subtitle: Text("$dateTime • $location"),
        leading: const Icon(Icons.event, color: Colors.blue),
      ),
    );
  }
}