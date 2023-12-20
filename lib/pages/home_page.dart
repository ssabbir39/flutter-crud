import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation_using_flutter_firebase/services/firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

final Firestoreservice firestoreservice = Firestoreservice();

final TextEditingController controller = TextEditingController();

class _HomepageState extends State<Homepage> {
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: controller,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreservice.addnote(controller.text);
              controller.clear();
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreservice.getNoteStream(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List noteList = snapshot.data!.docs;

            return ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = noteList[index];
                  String docId = document.id;

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data["note"];
                  return ListTile(
                    title: Text(noteText),
                  );
                });
          } else {
            return Text("Nothing");
          }
        }),
      ),
    );
  }
}
