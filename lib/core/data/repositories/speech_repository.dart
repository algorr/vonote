import 'package:cloud_firestore/cloud_firestore.dart' as firebase_store;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vonote/core/data/model/speech_model.dart';


class SpeechRepository {
  final firebase_store.FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Speech? speech;

  SpeechRepository({this.speech, firebase_store.FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore =
            firebaseFirestore ?? firebase_store.FirebaseFirestore.instance;

  var text = Speech.empty;

  Future saveUserData(String? user) async {
    try {

      await _firebaseFirestore.collection('users').doc(_firebaseAuth.currentUser?.uid).collection('notes').add({

              "id" : speech?.id,
              "note": text,

      });

    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
