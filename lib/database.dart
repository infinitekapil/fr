import 'package:fr/brew.dart';
import 'package:fr/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future<void> updateUserData(String Membername, String Mobilenumber, int Membershipnumber) async {
    return await brewCollection.document(uid).setData({
      'Membername': Membername,
      'Mobilenumber': Mobilenumber,
      'Membershipnumber': Membershipnumber,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Brew(
          Mobilenumber: doc.data['Mobilenumber'] ?? '',
          Membershipnumber: doc.data['Membershipnumber'] ?? 0,
          Membername: doc.data['Membername'] ?? '0'
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        Mobilenumber: snapshot.data['Mobilenumber'],
        Membername: snapshot.data['Membername'],
        Membershipnumber: snapshot.data['Membershipnumber']
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}