import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password, String adres, String phoneNo) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //create a file for users collection

      _firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        "email": email,
        "password": password,
        "adress": adres,
        "phoneNo": phoneNo,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> requestServiceHelp(
      String category, String detail, String adres) async {
    try {
      _firebaseFirestore.collection("service_request").doc().set({
        "category": category,
        "detail": detail,
        "adres": adres,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> requestSNeedHelp(
      String category, String detail, String adres) async {
    try {
      _firebaseFirestore.collection("necessity_request").doc().set({
        "category": category,
        "detail": detail,
        "adres": adres,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final String userId = _firebaseAuth.currentUser!.uid;

    final DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(userId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    final String? adress = data?["adress"];
    final String? email = data?["email"];
    final String? phoneNo = data?["phoneNo"];
    return data;
  }

}
