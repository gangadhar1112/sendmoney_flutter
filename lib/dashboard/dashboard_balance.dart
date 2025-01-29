import 'package:flutter/material.dart';

import '../send_money/screen/send_money_screen.dart';

class DashboardBalanceCard extends StatefulWidget {
  final String? balance;
  final Function? onTap, navigate;

  const DashboardBalanceCard(
      {super.key, required this.balance, this.onTap, this.navigate});

  @override
  _DashboardBalanceCardState createState() => _DashboardBalanceCardState();
}

class _DashboardBalanceCardState extends State<DashboardBalanceCard> {
  bool isBalanceVisible = false;
  late final VoidCallback onVisibilityToggle;

  @override
  void initState() {
    super.initState();
    onVisibilityToggle = _resetTimer;
  }

  // A function to hide the balance after 2 seconds
  void _resetTimer() {
    // After a visibility toggle, start the 2-second timer
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isBalanceVisible = false; // Mask the balance after 2 seconds
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(0.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Personal Wallet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBalanceVisible = !isBalanceVisible;
                        if (isBalanceVisible) {
                          _resetTimer();
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        isBalanceVisible
                            ? widget.balance != null &&
                                    widget.balance!.isNotEmpty
                                ? widget.balance.toString()
                                : '\$ ******'
                            : '\$ ******',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Available Balance',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.deepOrangeAccent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SendMoney(),
                            ),
                          );
                        },
                        label: const Text(
                          'Send Money',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  margin: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.onTap!();
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBalanceVisible = !isBalanceVisible;
                            if (isBalanceVisible) {
                              _resetTimer();
                            }
                          });
                        },
                        child: Icon(
                          isBalanceVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
