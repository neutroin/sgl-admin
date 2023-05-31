import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DatabaseServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateSingle(
    String Time,
    String A,
    String B,
    String C,
  ) async {
    try {
      var store = _firestore.collection('scores').doc('single');
      store.update({
        'latest': {
          'Time': Time,
          'A': A,
          'B': B,
          'C': C,
        }
      });

      // store.update({
      //   'preData': FieldValue.arrayUnion([
      //     {'Time': Time, 'A': A, 'B': B, 'C': C, 'Date': Timestamp.now()}
      //   ])
      // });
    } catch (e) {
      print(e);
    }
  }

  void updateLatestData(
    String doc,
    String Time,
    String A,
    String B,
    String C,
  ) async {
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    Map<String, dynamic> newData = {
      'Time': Time,
      'A': A,
      'B': B,
      'C': C,
      'Date': currentDate
    };
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('scores');
    DocumentReference documentRef = collectionRef.doc(doc);

    // Get the current 'latest' data
    DocumentSnapshot snapshot = await documentRef.get();
    if (snapshot.exists) {
      Map<String, dynamic> currentData =
          snapshot.data() as Map<String, dynamic>;

      // Move the current 'latest' data to 'preData' array
      List<Map<String, dynamic>> preData = List.from(currentData['preData']);
      preData.insert(0, currentData['latest']);

      // Update the 'latest' field with the new data
      await documentRef.update({
        'latest': newData,
        'preData': preData,
      });

      Fluttertoast.showToast(msg: 'Data is Submitted');
    }
  }
}
