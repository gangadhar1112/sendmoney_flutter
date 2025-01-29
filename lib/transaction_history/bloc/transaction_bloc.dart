import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sendmoney_interview/transaction_history/bloc/transaction_events.dart';
import 'package:sendmoney_interview/transaction_history/bloc/transaction_state.dart';

import '../../local_storage/local_storage.dart';

class RetrieveTransactionsBloc
    extends Bloc<RetrieveTransactionsEvent, RetrieveTransactionsState> {
  RetrieveTransactionsBloc() : super(RetrieveTransactionsInitial()) {
    on<RetrieveTransactionsRequested>(_onRetrieveTransactionsRequested);
    add(RetrieveTransactionsRequested());
  }

  // Event handler for RetrieveTransactionsRequested
  Future<void> _onRetrieveTransactionsRequested(
      RetrieveTransactionsRequested event,
      Emitter<RetrieveTransactionsState> emit) async {
    // Emit loading state
    emit(state.copyWith(status: Status.loading));

    try {
      // Attempt to fetch transactions (Firestore > LocalStorage fallback)
      List<Map<String, dynamic>> transactions = await _getTransactions();
      emit(state.copyWith(
        status: Status.success,
        transactions: transactions,
      ));
    } catch (e) {
      // Handle error and emit failure state
      emit(state.copyWith(
        status: Status.error,
        error: 'Error: $e',
      ));
    }
  }

  // Helper function to fetch transactions (Firestore > LocalStorage)
  Future<List<Map<String, dynamic>>> _getTransactions() async {
    try {
      // Fetch transactions from Firestore
      var snapshot = await FirebaseFirestore.instance
          .collection('sendMoney')
          .orderBy('time', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return {
          'amount': doc['amount'],
          'time': doc['time'].toDate().toIso8601String(),
          'user_name': doc['user_name']
        };
      }).toList();
    } catch (e) {
      return await LocalStorage.loadLocalTransactions();
    }
  }
}
