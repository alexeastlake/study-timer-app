import "package:cloud_firestore/cloud_firestore.dart";

class Controller {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static void addStudy(int percent) {
    final percentage = <String, dynamic> {};
    percentage["percentage"] = percent;
    
    db.collection("study").add(percentage);
  }

  static void addSleep(int time) {
    final minutes = <String, dynamic> {};
    minutes["minutes"] = time;
    
    db.collection("sleep").add(minutes);
  }
}