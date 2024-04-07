import 'package:dsit_app/consts/app_colors.dart';
import 'package:dsit_app/consts/app_const_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../firebase_db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    AppHelper().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return FutureBuilder<Map<String, dynamic>>(
      future: AppHelper().getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final userInfo = snapshot.data!;
          final email = userInfo['email'];
          final phoneNo = userInfo['phoneNo'];
          final address = userInfo['adress'];

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(AppConstString.home_page),
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    AppHelper().signOut();
                    Navigator.pushNamed(context, "/toAuthRoute");
                  },
                  icon: const Icon(Icons.logout_outlined),
                )
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.button_color,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppConstString.app_title),
                        Icon(Icons.help_center, size: 30,)
                      ],
                    )
                  ),
                  ListTile(
                    title: const Text('İhtiyaç Talebi Gönder'),
                    onTap: () {
                      Navigator.pushNamed(context, "/toNeed");
                    },
                  ),
                  ListTile(
                    title: const Text('Güvenlik Gücü Yardım Talebi '),
                    onTap: () {
                      Navigator.pushNamed(context, "/toHelp");
                    },
                  ),
                  ListTile(
                    title: const Text('Taleplerimi Görüntüle'),
                    onTap: () {
                      Navigator.pushNamed(context, "/toMyRequests");
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Duyurular",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Hesap Bilgileri",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text('📧 $email'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text('📞 $phoneNo'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text('📍 $address'),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.call),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
