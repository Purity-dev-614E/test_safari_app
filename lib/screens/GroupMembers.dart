import 'package:flutter/material.dart';


class Groupmembers extends StatefulWidget {
  const Groupmembers({super.key});

  @override
  State<Groupmembers> createState() => _GroupmembersState();
}

class _GroupmembersState extends State<Groupmembers> {

  //Dummy data for Members(To be replaced with dynamic data from backend)
  final List<Map<String , String>> members = [
    {"name": "Purity Sang", "Email" : "Purity@gmail.com", "role": "Group Admin"},
    {"name": "Patricia", "Email" : "Patricia@gmail.com", "role": "Normal User"},
    {"name": "George", "Email" : "george@gmail.com", "role": "Normal User"},
    {"name": "Julia ", "Email" : "Julia@gmail.com", "role": "Normal User"},
    {"name": "Enid ", "Email" : "Enid@gmail.com", "role": "Normal User"},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Group Members"
        ),
      ),
      body: Column(
        children: [
          //search bar
          Padding(
              padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value){
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search by Name or Email ...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Member List
          Expanded(
              child: ListView.builder(
                itemCount: members.length,
                  itemBuilder: (context , index){
                    final member = members[index];
                    final name = member["name"]!;
                    final email = member["Email"]!;
                    final role = member["role"]!;


                    if (!name.toLowerCase().contains(searchQuery) &&
                        !email.toLowerCase().contains(searchQuery)) {
                      return const SizedBox.shrink();
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5 ),
                      child: ListTile(
                        leading: const Icon(Icons.person,color: Colors.blue,),
                        title: Text(
                            name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                role,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 10,),
                            IconButton(
                                onPressed: (){},//Edit member logic
                                icon: const Icon(Icons.edit,color: Colors.orange,)
                            ),
                            IconButton(
                                onPressed: (){},//delete member logic
                                icon: const Icon(Icons.delete)
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              )
          )
        ],
      ),
      //floating Action Button
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            //navigate to Add Member screen
          },
        child: const Icon(Icons.person_add_alt),
      ),

      //Bottom nav
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
            label: "Dashboard"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
              label: "Group analytics"
            )
          ],
        onTap: (index){
            if (index == 0){
              Navigator.pushNamed(context, "/adminDashboard");
            }
            else if (index == 1){
              Navigator.pushNamed(context, "/GroupAnalytics");
            }
        },
      ),
    );
  }
}
