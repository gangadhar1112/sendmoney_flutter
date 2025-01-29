import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, error }

class RetrieveTransactionsState extends Equatable {
  final Status status;
  final List<Map<String, dynamic>>? transactions;
  final String? error;

  const RetrieveTransactionsState({
    this.status = Status.initial,
    this.transactions,
    this.error,
  });

  RetrieveTransactionsState copyWith({
    Status? status,
    List<Map<String, dynamic>>? transactions,
    String? error,
  }) {
    return RetrieveTransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, transactions, error];
}

class RetrieveTransactionsInitial extends RetrieveTransactionsState {}

class RetrieveTransactionsLoading extends RetrieveTransactionsState {}

class RetrieveTransactionsSuccess extends RetrieveTransactionsState {
  final List<Map<String, dynamic>> transactions;

  RetrieveTransactionsSuccess({required this.transactions})
      : super(status: Status.success, transactions: transactions);

  @override
  List<Object?> get props => [transactions];
}

class RetrieveTransactionsFailure extends RetrieveTransactionsState {
  final String error;

  RetrieveTransactionsFailure({required this.error})
      : super(status: Status.error, error: error);

  @override
  List<Object?> get props => [error];
}
