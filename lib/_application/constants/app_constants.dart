import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  factory AppConstants() {
    return I;
  }
  static final I = AppConstants._();

  final rootNavigatorKey = GlobalKey<ScaffoldMessengerState>();
  Reference? firebaseStorageRef;
}
