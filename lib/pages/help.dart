import 'package:dsit_app/consts/app_const_string.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../firebase_db_helper.dart';
import '../widgets/custom_button.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  String? selectedCategory;

  String _currentLocation = 'Konum bilgisi yükleniyor...';

  final detailController= TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateLocation();
  }

  void _updateLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentLocation = 'Enlem: ${position.latitude}, Boylam: ${position.longitude}, Doğruluk oranı ${position.accuracy} ';
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Konum bilgisine erişilemedi: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Güvenlik Gücü Yardım Talebi"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'İhtiyaç Seçiniz',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: AppConstString.categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'İhtiyaç Kategorisi',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Açıklama ve Ek Bilgi',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                 TextField(
                  controller: detailController,
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Konum Teyit ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(_currentLocation),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: CustomButtonWidget(
                      onPress: () {
                        try{
                          AppHelper().requestServiceHelp(selectedCategory!, detailController.text, _currentLocation);
                          Navigator.pushNamed(context, "/toHome");
                        }catch (e){
                        }
                      }, button_text: "Talep Gönder"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
}