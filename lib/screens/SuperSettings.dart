import 'package:flutter/material.dart';

class Supersettings extends StatefulWidget {
  const Supersettings({super.key});

  @override
  State<Supersettings> createState() => _SupersettingsState();
}

class _SupersettingsState extends State<Supersettings> {

  //Dummy group... Real will be fetched with an API
  List<String> groups = [
    'Choir','Youth','Sunday School'
  ];
  //Dummy permissions settings
  bool allowProfileEdits = true;

  //function to create a new group
  void _createGroup(){
    final TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text ("Create Group"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter Group Name",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
              ),
              TextButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty){
                      setState(() {
                        groups.add(controller.text);
                      });
                    }
                  },
                  child: const Text("Create")
              )
            ],
          );
        });
  }

  //Function to delete a group with confirmation
  void _deleteGroup(String group){
    showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Delete $group"),
          content: const Text("Are you sure you want to delete this group?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text("Cancel"),
            ),
            TextButton(
                onPressed: (){
                  setState(() {
                    groups.remove(group);
                  });
                  Navigator.pop(context);
                }, 
                child: Text(
                    "Delete Group",
                  style: TextStyle(
                    color: Colors.red
                  ),
                ))
          ],
        ));
  }

  void _toggleProfileEdits(bool value){
    setState(() {
      allowProfileEdits = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          //Group management section
          ListTile(
            title: const Text(
              "Group Management",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            trailing: IconButton(
                onPressed: _createGroup,
                icon: const Icon(Icons.add)
            ),
          ),
          const SizedBox(height: 8.0,),
          //List of groups with delete action
          ...groups.map((group){
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 0),
              child: ListTile(
                title: Text(group),
                trailing: IconButton(
                    onPressed: () => _deleteGroup(group),
                    icon: Icon(Icons.delete,color: Colors.red,)),
              ),
            );
          }).toList(),
          const Divider(height: 32,),

          //App permissions Section
          SwitchListTile(
              title: const Text(
                "Profile Edits",
                style: TextStyle(fontSize: 16.0),
              ),
              value: allowProfileEdits,
              onChanged: _toggleProfileEdits)
        ],
      ),
    );
  }
}
