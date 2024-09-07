import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showSubmittedDataInDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration:
                      InputDecoration(hintText: "Title", labelText: 'Title'),
                ),
                SizedBox(height: 10), // Space between the text fields
                TextField(
                  controller: _noteController,
                  decoration:
                      InputDecoration(hintText: "Note", labelText: 'Note'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Perform an action such as printing the values or handling submission
                print('Title: ${_titleController.text}');
                print('Note: ${_noteController.text}');
                Navigator.of(dialogContext)
                    .pop(); // Dismiss the dialog after the action
                _titleController.dispose(); // Dispose controllers
                _noteController.dispose();
              },
              child: const Text('Add Note'),
            ),
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
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // color: Colors.grey.shade300,
        decoration: BoxDecoration(
            color: Color.fromARGB(198, 226, 231, 241),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          title: Text(
            'Finalize the quarterly report by EOD.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'icons/checkbox.png',
                width: 27,
                height: 27,
              )),
          trailing: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'icons/pencil.png',
                width: 17,
                height: 17,
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                20)) // Adjust radius for more or less rounded corners
            ),
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
