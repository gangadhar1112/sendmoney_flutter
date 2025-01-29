import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sendmoney_interview/local_storage/local_storage.dart';

part 'send_money_events.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  // Constructor
  SendMoneyBloc() : super(SendMoneyState(status: Status.initial)) {
    on<SendMoneySubmitted>(_onSendMoneySubmitted);
    on<SendMoneyFetchLocalData>(_onFetchLocalData);
  }

  // Handle SendMoneySubmitted Event
  Future<void> _onSendMoneySubmitted(SendMoneySubmitted event, Emitter<SendMoneyState> emit) async {
    emit(SendMoneyLoading());

    try {
      bool isOnline = await _checkInternetConnection();
      if (isOnline) {
        await _sendMoneyToFirestore(event.amount);
        emit(SendMoneySuccess(message: 'Transaction successful'));
      } else {
        await _saveTransactionLocally(event.amount);
        emit(SendMoneySuccess(message: 'No internet, transaction saved locally'));
      }
    } catch (e) {
      emit(SendMoneyFailure(error: 'Error: $e'));
    }
  }

  // Handle SendMoneyFetchLocalData Event
  Future<void> _onFetchLocalData(SendMoneyFetchLocalData event, Emitter<SendMoneyState> emit) async {
    emit(SendMoneyLoading());

    try {
      var localTransactions = await _getLocalTransactions();
      emit(SendMoneyLocalDataLoaded(localTransactions: localTransactions));
    } catch (e) {
      emit(SendMoneyFailure(error: 'Error fetching local data: $e'));
    }
  }

  // Helper method to check if there's an internet connection
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  // Helper method to send money to Firestore
  Future<void> _sendMoneyToFirestore(double amount) async {
    CollectionReference sendMoneyRef = FirebaseFirestore.instance.collection('sendMoney');
    await sendMoneyRef.add({
      'amount': amount,
      'time': Timestamp.now(),
    });
  }

  // Helper method to save the transaction locally when there's no internet
  Future<void> _saveTransactionLocally(double amount) async {
    List<Map<String, dynamic>> transaction = [
      {
        'amount': amount,
        'time': DateTime.now().toIso8601String(),
      }
    ];

    await LocalStorage.saveTransactionLocally(transaction); // Use LocalStorage here
  }

  // Helper method to get locally saved transactions
  Future<List<Map<String, dynamic>>> _getLocalTransactions() async {
    return await LocalStorage.loadLocalTransactions(); // Use LocalStorage here
  }
}
