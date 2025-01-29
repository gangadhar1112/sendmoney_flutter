
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _key = 'transactions';  // Key for SharedPreferences

  // Save transaction to SharedPreferences
  static Future<void> saveTransactionLocally(List<Map<String, dynamic>> transactions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedTransactions = json.encode(transactions);
    await prefs.setString(_key, encodedTransactions);
  }

  // Load transactions from SharedPreferences
  static Future<List<Map<String, dynamic>>> loadLocalTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? transactionsJson = prefs.getString(_key);
    if (transactionsJson != null) {
      List<dynamic> decoded = json.decode(transactionsJson);
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  // Clear all saved transactions
  static Future<void> clearLocalTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
