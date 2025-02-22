import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/bottom_sheet_dialog.dart';
import '../../../utils/common_app_bar.dart';
import '../bloc/send_money_bloc.dart';

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
  final TextEditingController userName = TextEditingController();

  // Function to send money to Firestore
  void sendMoney() {
    FocusScope.of(context).unfocus();

    double amount = double.tryParse(amountController.text) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid amount'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (userName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter phone number'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (userName.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid phone number'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    context
        .read<SendMoneyBloc>()
        .add(SendMoneySubmitted(amount: amount, userName: userName.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Send Money',),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              maxLength: 8,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: const OutlineInputBorder(),
                prefixIcon: Container(
                  width: 60, // Adjust the width as needed
                  alignment: Alignment.center,
                  child: const Text(
                    'PHP',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: userName,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            BlocListener<SendMoneyBloc, SendMoneyState>(
              listener: (context, state) {
                if (state is SendMoneyFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: ${state.error}'),
                    backgroundColor: Colors.red,
                  ));
                }

                if (state is SendMoneySuccess) {
                  // Show a BottomSheet with the success message when the transaction succeeds
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    // Makes sure the sheet height is dynamic
                    builder: (_) {
                      return Container(
                        width: double.infinity, // Set width to full
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 80,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              state.message ?? 'Transaction Successful',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Close the bottom sheet
                                Navigator.of(context)
                                    .pop(); // Go back to the previous screen
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: sendMoney,
                      child: const Text(
                        'Send Money',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
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
