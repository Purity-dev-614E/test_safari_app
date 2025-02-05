import 'package:flutter/material.dart';


class SuperAdminDashoard extends StatelessWidget {
  const SuperAdminDashoard({super.key});
  
  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
}){
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,size: 40,color: color,),
          const SizedBox(height: 8,),
          Text(
            value,
            style: const TextStyle(
                fontSize: 24,
            fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4,),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
}){
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'DashBoard',
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){}, // Future to trigger data refresh
              icon: const Icon(Icons.refresh)
          ),
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/SuperSettings');
              },// Navigate to the settings screen
              icon: Icon(Icons.settings)
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildSummaryCard(
                          icon: Icons.person,
                          label: "Total Users",
                          value: "150",
                          color: Colors.blue)
                  ),
                  Expanded(
                      child: _buildSummaryCard(
                          icon: Icons.group,
                          label: "Total Groups",
                          value: '12',
                          color: Colors.green)
                  ),

                ],
              ),
              const SizedBox(height: 16.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickActionButton(
                      label: "Create Group",
                      icon: Icons.add,
                      onPressed: (){} //navigate to create group form
                  )
                ],
              ),
              const SizedBox(height: 24.0,),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    "Attendance Trends",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24,),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    "Group Statistics",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),

        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
                onPressed: (){
                  Navigator.pushNamed(context, '/UserManagement');
                },// navigate to User Management screen
                icon: Icon(Icons.people_outlined),
                label: const Text("User Management"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
                Navigator.pushNamed(context, "/SuperAnalytics");
              },// navigate to User Management screen
              icon: Icon(Icons.analytics),
              label: const Text("Analytics"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
