part of 'send_money_bloc.dart';

enum Status { initial, loading, success, error }

class SendMoneyState extends Equatable {
  final Status status;
  final String? message;
  final String? error;
  final List<Map<String, dynamic>>? localTransactions;

  SendMoneyState({
    this.status = Status.initial,
    this.message,
    this.error,
    this.localTransactions,
  });

  SendMoneyState copyWith({
    Status? status,
    String? message,
    String? error,
    List<Map<String, dynamic>>? localTransactions,
  }) {
    return SendMoneyState(
      status: status ?? this.status,
      message: message ?? this.message,
      error: error ?? this.error,
      localTransactions: localTransactions ?? this.localTransactions,
    );
  }

  @override
  List<Object?> get props => [status, message, error, localTransactions];
}

class SendMoneyLoading extends SendMoneyState {
  SendMoneyLoading() : super(status: Status.loading);
}

class SendMoneySuccess extends SendMoneyState {
  SendMoneySuccess({String? message})
      : super(status: Status.success, message: message);
}

class SendMoneyFailure extends SendMoneyState {
  SendMoneyFailure({String? error})
      : super(status: Status.error, error: error);
}

class SendMoneyLocalDataLoaded extends SendMoneyState {
  SendMoneyLocalDataLoaded({required List<Map<String, dynamic>> localTransactions})
      : super(status: Status.success, localTransactions: localTransactions);
}
