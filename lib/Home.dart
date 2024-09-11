import 'package:flutter/material.dart';
import 'db.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class HomePage extends StatefulWidget {
  final String email;
  final String userName;
  const HomePage({required this.email , required this.userName , super.key});

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
                        notes[title]=note;
                        notesComp[note] = false; // Default new notes as not completed
                      });
                    }
                    _titleController.clear();
                    _noteController.clear();
                    Navigator.pop(context );
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
          String Note = notes.values.elementAt(index);
          bool isCompleted = notesComp[Note]!;
          return Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.16,
              motion: ScrollMotion(),
              children: [
                GestureDetector(
                  onTap: () {
                    notes.remove(noteTitle);
                    notesComp.remove(Note);

                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red.shade400,),
                    height: 55,
                    width: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/delete.png'),
                          color: Colors.white,
                          size: 35, // Customize the size here
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                ),
              ],
            ),
            child: GestureDetector(
              onLongPress: (){
                showAboutDialog(context: context);
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: isCompleted ? Colors.indigo.shade50 : Colors.white70,
                ),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                child: ListTile(
                  title: GestureDetector(
                    onTap: (){
                      setState(() {
                        notesComp[Note] = !isCompleted;
                      });
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
                        children: [
                          Row(
                            children: [
                              Expanded( // Allow text to take available space
                                child: Text(
                                  noteTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                                  maxLines: 1, // Limit to 1 line to prevent overflow
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded( // Allow text to take available space
                                child: Text(
                                  Note,
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                                  maxLines: 2, // Limit to 2 lines
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                    leading: IconButton(
                      onPressed: () {
                        setState(() {
                          notesComp[Note] = !isCompleted;
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
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Center(
                                child: const Text(
                                  'Edit Task',
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
                                      final String title =_titleController.text.trim() ;
                                      final String note = notes[_titleController.text.trim()]!;
                                      setState(() {
                                        notes[title]=note;
                                        // notesComp[note] = false; // Default new notes as not completed
                                      });
                                      // _titleController.clear();
                                      // _noteController.clear();
                                      Navigator.pop(context );
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
                                          'Edit',
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
                        },);
                      },
                      icon: ImageIcon(
                        AssetImage('assets/icons/edit.png'),
                        size: 22,
                      )),
                ),
              ),
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
              accountName: Text(widget.userName,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18)),
              accountEmail: Text(widget.email ,style: TextStyle(color: Colors.grey.shade400 ,)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profilepic.png'),
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
              // contentPadding: EdgeInsets.only(left: 15),
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
