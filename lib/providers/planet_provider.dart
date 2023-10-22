import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_planet/models/planet.dart';

class PlanetProvider extends ChangeNotifier{
  List<Planet> _planets = [];
  int _selectedIndex = 0;

  List<Planet> get planets => _planets;
  int get selectedIndex => _selectedIndex;

  void fetchData()async{
    String data = await rootBundle.loadString('assets/json/planet.json');
    _planets = planetFromJson(data);
    notifyListeners();
  }

  void chageIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }
  
}