import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'dashboard/dashboard_screen.dart';
import 'firebase_options.dart';
import 'local_storage/local_storage.dart';

void syncLocalTransactions() async {
  bool isOnline = await checkInternetConnection();

  if (isOnline) {
    // Get local transactions
    List<Map<String, dynamic>> localTransactions = await LocalStorage.loadLocalTransactions();

    if (localTransactions.isNotEmpty) {
      for (var transaction in localTransactions) {
        try {
          // Save the transaction to Firestore
          await FirebaseFirestore.instance.collection('sendMoney').add({
            'amount': transaction['amount'],
            'time': DateTime.parse(transaction['time']),
          });

          // Clear local transactions once they're successfully synced
          await LocalStorage.clearLocalTransactions();
        } catch (e) {
          print("Failed to sync transaction: $e");
        }
      }
    }
  }
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const DashboardScreen(),
    );
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}
