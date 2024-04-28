import 'package:dsit_app/consts/app_colors.dart';
import 'package:dsit_app/consts/app_const_string.dart';
import 'package:flutter/material.dart';

import '../firebase_db_helper.dart';
import '../user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return FutureBuilder<User?>(
        future: UserService().fetchCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            final User? currentUser = UserService.currentUser;
            return _buildScaffold(_scaffoldKey, context, currentUser);
          } else {
            return const Text("ERror");
          }
        });
  }

  Scaffold _buildScaffold(GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context, User? currentUser) {
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
                    Icon(
                      Icons.help_center,
                      size: 30,
                    )
                  ],
                )),
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
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(tabs: [
                    Tab(text: "Uyarılar"),
                    Tab(text: "Dikkat Edilmesi Gerekenler")
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: const TabBarView(children: [
                      Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.warning),
                            title: Text(
                                'Hatay Bölgesinde deprem'),
                            subtitle: Text(
                                'Kırkhan - 4.4 - 10km derinlik'),
                          ),
                          ListTile(
                            leading: Icon(Icons.warning),
                            title: Text(
                                'Mersin Bölgesinde deprem'),
                            subtitle: Text(
                                'Yenişehir - 1.4 - 7km derinlik'),),
                        ],
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.check_circle),
                            title: Text('Deprem anında yapılması gerekenler'),
                            subtitle: Text(
                                '1. Sakin olun, panik yapmayın.\n2. Güvenli bir alana geçin.\n3. Tehlikeli eşyaları tutun veya kapatın.'),
                          ),
                          ListTile(
                            leading: Icon(Icons.check_circle),
                            title: Text('Acil durum çantası hazırlığı'),
                            subtitle: Text(
                                'Acil durum çantasında gerekli ilaçlar, su ve temel malzemeler bulunmalıdır.'),
                          ),
                          ListTile(
                            leading: Icon(Icons.warning),
                            title: Text(
                                'Hatalı depolama durumunda tehlike oluşturabilecek kimyasal maddeler'),
                            subtitle: Text(
                                'Depolama koşullarına uygun olmayan kimyasal maddelerin saklanması risk oluşturabilir.'),
                          ),
                          ListTile(
                            leading: Icon(Icons.warning),
                            title: Text('Yangın güvenlik prosedürleri'),
                            subtitle: Text(
                                'Yangın tüplerinin doğru kullanımı ve yangın söndürme cihazlarının yerlerinin bilinmesi önemlidir.'),
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
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
              child: Text('📧 ${currentUser?.email}'),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text('📞 ${currentUser?.phoneNo}'),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text('📍 ${currentUser?.adress}'),
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
            ),
          ],
        ),
      ),
    );
  }
}
