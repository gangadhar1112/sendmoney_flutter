import 'package:flutter/material.dart';
import 'package:sendmoney_interview/send_money/screen/send_money_screen.dart';
import 'package:sendmoney_interview/transaction_history/screen/transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon for Send Money
            GestureDetector(
              onTap: () {
                // Navigate to Send Money Page and provide the SendMoneyBloc
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendMoney(),
                  ),
                );
              },
              child: const Icon(Icons.send, size: 100, color: Colors.blue),
            ),


            const SizedBox(height: 20),


            GestureDetector(
              onTap: () {
                // Navigate to Send Money Page and provide the SendMoneyBloc
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RetrieveTransactionsScreen(),
                  ),
                );
              },
              child: const Icon(Icons.send, size: 100, color: Colors.blue),
            ),



          ],
        ),
      ),
    );
  }
}