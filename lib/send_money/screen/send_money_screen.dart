import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendmoney_interview/send_money/bloc/send_money_bloc.dart';

class SendMoney extends StatelessWidget {
  const SendMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendMoneyBloc(),
      child: const SendMoneyScreen(),
    );
  }
}

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController amountController = TextEditingController();

  // Function to send money to Firestore
  void sendMoney() {
    double amount = double.tryParse(amountController.text) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid amount')));
      return;
    }

    // Dispatch SendMoneySubmitted event
    context.read<SendMoneyBloc>().add(SendMoneySubmitted(amount: amount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendMoney, // Trigger SendMoneySubmitted event
              child: const Text('Send Money'),
            ),
            BlocListener<SendMoneyBloc, SendMoneyState>(
              listener: (context, state) {
                if (state is SendMoneyFailure) {
                  // Show an error message on failure
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')));
                }
                if (state is SendMoneySuccess) {
                  // Show a success message when transaction succeeds
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message ?? 'Success')));
                }
              },
              child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    // Show loading indicator when the status is 'loading'
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == Status.error) {
                    return Text('Error: ${state.error}');
                  } else if (state.status == Status.success) {
                    return Text(state.message ?? 'Transaction Successful');
                  } else {
                    return const SizedBox(); // Default empty widget
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
