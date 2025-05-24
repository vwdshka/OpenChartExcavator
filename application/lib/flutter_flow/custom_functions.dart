import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

String? locationToString(LatLng? inputLocation) {
  if (inputLocation == null) {
    return null;
  }
  return '${inputLocation.latitude},${inputLocation.longitude}';
}

List<LatLng>? listDoubleToLatLng(
  List<double>? latitude,
  List<double>? longtitude,
) {
  // return latitude and longtitude combined
  if (latitude == null ||
      longtitude == null ||
      latitude.length != longtitude.length) {
    return null;
  }

  List<LatLng> latLngList = [];
  for (int i = 0; i < latitude.length; i++) {
    latLngList.add(LatLng(latitude[i], longtitude[i]));
  }

  return latLngList;
}

String? locationToLatLng(String? latlong) {
  if (latlong == null) {
    return null;
  }
  final regex = RegExp(r'LatLng\(lat: (.*), lng: (.*)\)');
  final match = regex.firstMatch(latlong);
  if (match != null && match.groupCount == 2) {
    final lat = double.tryParse(match.group(1)!);
    final lng = double.tryParse(match.group(2)!);
    if (lat != null && lng != null) {
      return '$lat,$lng';
    }
  }
  return null;
}

int? indexMarkerIdentifier(
  LatLng? centerMarkerCoordinate,
  List<LatLng>? listofLocation,
) {
  if (centerMarkerCoordinate == null || listofLocation == null) {
    return null;
  }
  for (int i = 0; i < listofLocation.length; i++) {
    if (centerMarkerCoordinate == listofLocation[i]) {
      return i;
    }
  }
}
