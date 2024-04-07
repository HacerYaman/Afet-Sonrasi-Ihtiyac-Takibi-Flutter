import "package:dsit_app/consts/app_colors.dart";
import "package:dsit_app/widgets/custom_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:geolocator/geolocator.dart";

import "../firebase_db_helper.dart";

class NeedPage extends StatefulWidget {
  NeedPage({super.key});

  @override
  State<NeedPage> createState() => _NeedPageState();
}

class _NeedPageState extends State<NeedPage> {
  final List<String> categories = [
    'Erzak',
    'Kıyafet',
    'Su',
    'Barınma',
    'Sağlık',
    'Diğer'
  ];
  String? selectedCategory;

  String _currentLocation = 'Konum bilgisi yükleniyor...';

  final _detailController= TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateLocation();
  }

  void _updateLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentLocation = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}, Doğruluk oranı ${position.accuracy} ';
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
        title: const Text("İhtiyaç Talebi Gönder"),
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
                  items: categories.map((String category) {
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
                  controller: _detailController,
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Konum Teyit',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(_currentLocation),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: CustomButtonWidget(
                      onPress: () {
                        {
                          try {
                            AppHelper().requestSNeedHelp(selectedCategory!,
                                _detailController.text, "adres");
                            Navigator.pushNamed(context, "/toHome");
                          } catch (e) {}
                        }
                      },
                      button_text: "Talep Gönder"),
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