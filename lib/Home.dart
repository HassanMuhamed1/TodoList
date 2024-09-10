import 'package:flutter/material.dart';
import 'db.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String password;
  const HomePage({required this.email , required this.password , super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Create the GlobalKey
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void showSubmittedDataInDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
              child: const Text(
                'New Task',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(235, 47, 0, 255)),
              )),
          content: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.indigo),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: 'Note',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
                child: InkWell(
                  onTap: () {
                    final String title = _titleController.text.trim();
                    final String note = _noteController.text.trim();

                    // Ensure the title is not empty
                    if (title.isNotEmpty) {
                      setState(() {
                        notes[title] = false; // Default new notes as not completed
                      });
                    }
                    _titleController.clear();
                    _noteController.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 63, 55, 204),
                          Color.fromARGB(255, 36, 92, 170)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? userName = usersName[widget.email];
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openEndDrawer();// Use the GlobalKey to open the drawer
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ImageIcon(
              AssetImage('assets/icons/list.png'), // Custom icon here
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        ],
        backgroundColor: Colors.indigo,
        title: Text(
          'To-Do',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white,fontSize: 25),
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          String noteTitle = notes.keys.elementAt(index);
          bool isCompleted = notes[noteTitle]!;
          return Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: isCompleted ? Colors.indigo.shade50 : Colors.white70,
            ),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(
                noteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      notes[noteTitle] = !isCompleted;
                    });
                  },
                  icon: ImageIcon(
                    isCompleted
                        ? AssetImage('assets/icons/check-box.png')
                        : AssetImage('assets/icons/checkbox.png'),
                    color: isCompleted
                        ? Colors.indigoAccent.withOpacity(0.92)
                        : Colors.black.withOpacity(0.3),
                    size: 23,
                  )),
              trailing: IconButton(
                  onPressed: () {
                    // Edit functionality goes here
                  },
                  icon: ImageIcon(
                    AssetImage('assets/icons/edit.png'),
                    size: 22,
                  )),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () {
          showSubmittedDataInDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: Color.fromARGB(255, 89, 107, 209),
      ),
      endDrawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('$userName',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18)),
              accountEmail: Text(widget.email ,style: TextStyle(color: Colors.grey.shade400 ,)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_picture.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
            ),

            ListTile(
              leading: ImageIcon(AssetImage('assets/icons/setting (1).png'),size: 20,),
              title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Handle settings
              },
            ),
            ListTile(
              leading: ImageIcon(AssetImage('assets/icons/info.png') ,size: 20,),
              title: Text('About',style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Handle about
              },
            ),
            ListTile(
              leading: ImageIcon(AssetImage('assets/icons/logout.png'),size: 20,),
              title: Text('Sign Out' , style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),

          ],
        ),
      ),
    );
  }
}
