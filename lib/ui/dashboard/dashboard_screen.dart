import 'package:flutter/material.dart';
import 'package:sendmoney_interview/utils/common_app_bar.dart';

import '../../utils/bottom_sheet_dialog.dart';
import '../send_money/screen/send_money_screen.dart';
import '../transaction_history/screen/transaction_screen.dart';
import 'dashboard_balance.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CommonAppBar(title: 'Wallet',showBackButton: false,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const DashboardBalanceCard(
              balance: 'PHP 5000.00',
            ),
            // Quick Menu Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Menu Text
                    const Text(
                      'Quick Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20), // Space between title and row

                    // Row containing the Send Money and Transactions cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Send Money Card
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SendMoney(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.send,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Send Money',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Spacer between the two cards
                        const SizedBox(width: 20),

                        // Transactions Card
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransactionScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.history,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Transactions',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}