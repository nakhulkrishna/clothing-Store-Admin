import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thestyldclubadmin/data/repositorys/authentication_repository/authentication_repository.dart';
import 'package:thestyldclubadmin/firebase_options.dart';
import 'app.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage
  await GetStorage.init();
  
  // Remove # sign from url


  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((onValue) => Get.put(AuthenticationRepository()));
  // Main App Starts here....then
  runApp(const App());
}
