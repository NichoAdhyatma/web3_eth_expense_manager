import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/core/utils/sizedbox_ext.dart';
import 'package:flutter_web3/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_web3/models/transaction_model.dart';

class WithdrawPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const WithdrawPage(),
      );

  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    final TextEditingController addressController = TextEditingController();

    final TextEditingController reasonController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    hintText: 'Enter address',
                  ),
                ),
                16.heightSB,
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    hintText: 'Enter amount',
                  ),
                ),
                16.heightSB,
                TextFormField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason',
                    hintText: 'Enter reason',
                  ),
                ),
                24.heightSB,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[500],
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            DashboardWithdrawEvent(
                              TransactionModel(
                                amount: int.parse(amountController.text),
                                reason: reasonController.text,
                                address: addressController.text,
                                timestamp: DateTime.now(),
                              ),
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '- WITHDRAW',
                      style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
