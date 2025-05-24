import 'package:flutter/material.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _currentLocation =
          latLngFromString(prefs.getString('ff_currentLocation')) ??
              _currentLocation;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _toggle = false;
  bool get toggle => _toggle;
  set toggle(bool value) {
    _toggle = value;
  }

  List<LatLng> _LatLon = [];
  List<LatLng> get LatLon => _LatLon;
  set LatLon(List<LatLng> value) {
    _LatLon = value;
  }

  void addToLatLon(LatLng value) {
    LatLon.add(value);
  }

  void removeFromLatLon(LatLng value) {
    LatLon.remove(value);
  }

  void removeAtIndexFromLatLon(int index) {
    LatLon.removeAt(index);
  }

  void updateLatLonAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    LatLon[index] = updateFn(_LatLon[index]);
  }

  void insertAtIndexInLatLon(int index, LatLng value) {
    LatLon.insert(index, value);
  }

  String _placeType = '';
  String get placeType => _placeType;
  set placeType(String value) {
    _placeType = value;
  }

  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;
  set currentLocation(LatLng? value) {
    _currentLocation = value;
    value != null
        ? prefs.setString('ff_currentLocation', value.serialize())
        : prefs.remove('ff_currentLocation');
  }

  bool _popupvisible = false;
  bool get popupvisible => _popupvisible;
  set popupvisible(bool value) {
    _popupvisible = value;
  }

  String _recenterLocation = '';
  String get recenterLocation => _recenterLocation;
  set recenterLocation(String value) {
    _recenterLocation = value;
  }

  bool _bottomSheet = false;
  bool get bottomSheet => _bottomSheet;
  set bottomSheet(bool value) {
    _bottomSheet = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
