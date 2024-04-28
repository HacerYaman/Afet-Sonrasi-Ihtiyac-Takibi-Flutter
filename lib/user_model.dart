import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String email;
  final String phoneNo;
  final String adress;
  final String uid;


  User({
    required this.email,
    required this.phoneNo,
    required this.adress,
    required this.uid,

  });
}

class UserService {
  static User? currentUser;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> fetchCurrentUser() async {
    final currentUserUID = _firebaseAuth.currentUser?.uid;

    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUID)
        .get();

    final data = snapshot.data() as Map<String, dynamic>;
    final email = data['email'].toString();
    final phoneNo = data['phoneNo'].toString();
    final adress = data['adress'].toString();
    final uid = data['uid'].toString();


    currentUser = User(

      email: email,
      phoneNo: phoneNo,
      adress: adress,
      uid: uid,
    );
    return currentUser;
  }
}
