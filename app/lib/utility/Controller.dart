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

  static Future<int> getAverageStudyPercent() {
    return db.collection("study").get().then((QuerySnapshot querySnapshot) {
      int sum = 0;

      for (var element in querySnapshot.docs) {
        sum += element.get("percentage") as int;
      }

      if (sum == 0) {
        return 0;
      }

      return (sum / querySnapshot.size).round();
    });
  }

  static Future<int> getAverageSleepTime() {
    return db.collection("sleep").get().then((QuerySnapshot querySnapshot) {
      int sum = 0;

      for (var element in querySnapshot.docs) {
        sum += element.get("minutes") as int;
      }

      if (sum == 0) {
        return 0;
      }

      return (sum / querySnapshot.size).round();
    });
  }

  static void clearData() {
    db.collection("study").get().then((result) {
      for (DocumentSnapshot snapshot in result.docs) {
        snapshot.reference.delete();
      }
    });

    db.collection("sleep").get().then((result) {
      for (DocumentSnapshot snapshot in result.docs) {
        snapshot.reference.delete();
      }
    });
  }
}