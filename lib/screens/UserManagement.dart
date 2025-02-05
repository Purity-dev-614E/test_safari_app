import 'package:flutter/material.dart';

class User{
  final String name;
  final String email;
  final String role;
  final String group;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.group,
  });
}



class Usermanagement extends StatefulWidget {
  const Usermanagement({super.key});

  @override
  State<Usermanagement> createState() => _UsermanagementState();
}

class _UsermanagementState extends State<Usermanagement> {

  List<User> users = [
    User(name: 'Purity Sang', email:"Purity@gmail.com", role: "Admin", group: "Youth"),
    User(name: "Bob Smith", email: "Bob@gmail.com", role: "Member", group: "Choir"),
    User(name: "Patricia", email: "patricia@gmail.com", role: "Member", group: "Sunday"),
    User(name: "David", email: "David@gmail.com", role: "Admin", group: "Choir")
  ];

  String searchQuery = '';

  List<User> get filteredUsers{
    if (searchQuery.isEmpty)return users;
    return users.where((user){
      final lowerCaseQuery = searchQuery.toLowerCase();
      return user.name.toLowerCase().contains(lowerCaseQuery) ||
      user.email.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  void _onEditUser(User user){
    //Open an edit dialog or navigate to an edit screen(form)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Edit user: ${user.name}"))
    );
  }

  void _onDeleteUser(User user){
    // Show a Configaration Dialog before deletion
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text("Delete ${user.name}"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
            ),

            TextButton(
                onPressed: (){
                  setState(() {
                    users.remove(user);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red
                  ),
                )
            )
          ],
        )
    );
  }

  void _onAssignGroup(User user, String newGroup) {
    // Update the user group assignment using API
    setState(() {
      int index = users.indexOf(user);
      users[index] = User(
          name: user.name, 
          email: user.email, 
          role: user.role, 
          group: user.group
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${user.name} assigned to $newGroup")),
    );
  }

  void _onAddUser(){
    //Naviagate to an "Ad User" form or Open a dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigate to Add User Screen')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
      ),
      body: Column(
        children: [
          //search Bar
          Padding(
              padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Name or Email",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value){
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          //User list
          Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                  itemBuilder: (context, index){
                    final user = filteredUsers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                      child: ListTile(
                        title: Text(user.name),
                        subtitle: Text("${user.email} • ${user.role} • ${user.group}"),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            //edit button
                            IconButton(
                                onPressed: () => _onEditUser(user), 
                                icon: Icon(
                                    Icons.edit,
                                  color: Colors.blue,
                                )
                            ),
                            //Delete Button
                            IconButton(
                                onPressed: () => _onDeleteUser(user),
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.blue,
                                )
                            ),
                            //Assign Group Dropdown
                            DropdownButton<String>(
                              underline: const SizedBox(),
                              icon: const Icon(Icons.group,color: Colors.green,),
                              onChanged: (newGroup){
                                if (newGroup != null) _onAssignGroup(user, newGroup);
                              },
                              items: <String> [
                                "Choir","Youth","Sunday School"
                              ].map<DropdownMenuItem<String>>((String group){
                                return DropdownMenuItem<String>(
                                value: group,
                                child: Text(group),
                                );
                              },
                              ).toList()
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _onAddUser,
        tooltip: "Add User",
        child: const Icon(Icons.add),
      ),
    );
  }
}
