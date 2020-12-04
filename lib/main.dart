import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zapiti_desafio/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  setupSingletons();
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp().then((v) {
    runApp(ModularApp(module: AppModule()));
  });
}
GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
