
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoreservice {
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  // get colleection of notes


  //create:add a new note
  Future<void> addnote (String note){
     return notes.add({
      'note':note,
      'timestamp' : Timestamp.now (),
     });
  }

  //read:get note from database

  Stream<QuerySnapshot> getNoteStream(){
    final note = notes.orderBy("timestamp", descending: true).snapshots();
    return note;
  }

  //update:update notes given a doc id

  //delate:delate notes given a doc id
}
