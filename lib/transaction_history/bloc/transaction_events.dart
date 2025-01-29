import 'package:equatable/equatable.dart';

abstract class RetrieveTransactionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RetrieveTransactionsRequested extends RetrieveTransactionsEvent {}
