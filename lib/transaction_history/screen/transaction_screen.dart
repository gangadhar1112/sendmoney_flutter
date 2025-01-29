import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendmoney_interview/transaction_history/bloc/transaction_bloc.dart';
import 'package:sendmoney_interview/transaction_history/bloc/transaction_events.dart';
import 'package:sendmoney_interview/transaction_history/bloc/transaction_state.dart';

class RetrieveTransactionsScreen extends StatelessWidget {
  const RetrieveTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction List')),
      body: BlocProvider(
        create: (_) => RetrieveTransactionsBloc()..add(RetrieveTransactionsRequested()),
        child: BlocBuilder<RetrieveTransactionsBloc, RetrieveTransactionsState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == Status.success) {
              var transactions = state.transactions!;
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  var amount = transaction['amount'];
                  var time = DateTime.parse(transaction['time']);
                  return ListTile(
                    title: Text('Amount: \$${amount.toString()}'),
                    subtitle: Text('Date: ${time.toLocal()}'),
                  );
                },
              );
            } else if (state.status == Status.error) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const Center(child: Text('No Transactions Found'));
          },
        ),
      ),
    );
  }
}
