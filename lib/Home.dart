import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Declare the controllers at the class level
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
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
          title: Center(child: const Text('New Task',style:TextStyle(fontWeight: FontWeight.w500 , color: Color.fromARGB(235, 47, 0, 255)),)),
          content: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                TextField(
                  controller: _titleController,
                  decoration:
                      InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400 , color: Colors.indigo),
                      ),
                ),
                SizedBox(height: 30), // Space between the text fields
                TextField(
                  controller: _noteController,
                  decoration:
                      InputDecoration( labelText: 'Note',labelStyle: TextStyle(fontWeight: FontWeight.w400 , color: Colors.indigo),),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 63, 55, 204), // Start color of the gradient
                        Color.fromARGB(
                            255, 36, 92, 170) // End color of the gradient
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
              )            ),
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
                'assets/icons/checkbox.png',
                width: 27,
                height: 27,
              )),
          trailing: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/pencil.png',
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
