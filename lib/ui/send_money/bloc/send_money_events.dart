
part of 'send_money_bloc.dart';

abstract class SendMoneyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMoneySubmitted extends SendMoneyEvent {
  final double amount;
  final String userName;

  SendMoneySubmitted({required this.amount,required this.userName});

  @override
  List<Object?> get props => [amount];
}

// This event will be used to fetch local data when there's no internet
class SendMoneyFetchLocalData extends SendMoneyEvent {
  @override
  List<Object?> get props => [];  // No properties for this event
}
