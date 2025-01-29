import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sendmoney_interview/utils/common_app_bar.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_events.dart';
import '../bloc/transaction_state.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RetrieveTransactionsBloc(),
      child: const RetrieveTransactionsScreen(),
    );
  }
}

class RetrieveTransactionsScreen extends StatelessWidget {
  const RetrieveTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Transactions'),
      body: BlocBuilder<RetrieveTransactionsBloc, RetrieveTransactionsState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == Status.success) {
            var transactions = state.transactions!;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RetrieveTransactionsBloc>().add(
                  RetrieveTransactionsRequested(),
                );
              },
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  var amount = transaction['amount'];
                  var time = DateTime.parse(transaction['time']);

                  // Format the date to show date and time (HH:mm:ss)
                  String formattedDate = DateFormat('MM/dd/yyyy HH:mm:ss').format(time);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text('Amount: \$${amount.toString()}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),

                          Text('Phone No.: ${transaction['user_name']}'),
                          const SizedBox(height: 8),
                          Text('Date: $formattedDate'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state.status == Status.error) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return const Center(child: Text('No Transactions Found'));
        },
      ),
    );
  }
}
