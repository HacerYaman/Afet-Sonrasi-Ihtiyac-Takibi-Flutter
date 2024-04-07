import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taleplerim"),
      ),
      body: FutureBuilder(
        future: _getMyRequests(),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final requests = snapshot.data!;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(request['category'] as String),
                  subtitle: Text(request['detail'] as String),
                  // Burada diğer talep bilgilerini de ekle
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> _getMyRequests() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("Kullanıcı oturum açık değil.");
    }
    final userId = currentUser.uid;
    final querySnapshot = await _firestore
        .collection("service_request")
        .where("userid", isEqualTo: userId)
        .get();
    return querySnapshot.docs;
  }
}
