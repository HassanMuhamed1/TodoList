import 'package:flutter/material.dart';
import 'db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    // Add the new note to the notes map
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.indigo,
        title: Text(
          'To-Do',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
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
              color: isCompleted?Colors.indigo.shade50: Colors.white70,
            ),
            margin: EdgeInsets.symmetric(horizontal:  8, vertical: 4),
            child: ListTile(
              title: Text(
                noteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  decoration: isCompleted?TextDecoration.lineThrough : null,
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      notes[noteTitle] =!isCompleted;
                    });
                  },
                  icon: Icon(
                    isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: isCompleted ? Colors.indigoAccent : Colors.grey,
                    size: 27,
                  )),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    size: 17,
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
    );
  }
}
