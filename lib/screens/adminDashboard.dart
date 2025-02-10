import 'package:flutter/material.dart';



class adminDashboard extends StatelessWidget {
  const adminDashboard({super.key});

  Widget _buildSummaryCard(String title, String value, IconData icon){
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon,size: 40, color: Colors.blue,),
            const SizedBox(height: 8,),
            Text(
              title,style:
            const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Group Name Header
            Text(
              "Youth Group", //Replace dynamically later
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16,),

            //summary cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard(
                    "Members",
                    '120',
                    Icons.people_alt),
                _buildSummaryCard(
                    "Upcoming Events",
                    '5',
                    Icons.event)
              ],
            ),

            //Quick Actions
            ElevatedButton.icon(
                onPressed: (){},//navigate to add members screen (form)
                icon: Icon(Icons.person_add_alt_1),
                label: const Text("Add Member")
            )
          ],
        ),
      ),
      //floating ActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: (){},//navigate to Add member Screen
        child: const Icon(Icons.person_add_alt_1),
      ),

      //bottom nav
      bottomNavigationBar: BottomNavigationBar(
        items: const[

          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: "Members"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Analytics'
          ),

        ],
        onTap: (index){
          //Handle Navigation
          if (index == 0){
            Navigator.pushNamed(context, "/GroupMembers");
          }
          else if(index == 1){
            Navigator.pushNamed(context, "/GroupAnalytics");
          }
        },
      ),
    );
  }
}

