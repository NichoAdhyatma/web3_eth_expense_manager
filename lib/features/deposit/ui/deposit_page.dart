import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/core/utils/sizedbox_ext.dart';
import 'package:flutter_web3/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_web3/main.dart';
import 'package:flutter_web3/models/transaction_model.dart';

class DepositPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const DepositPage(),
      );

  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    final TextEditingController addressController = TextEditingController();

    final TextEditingController reasonController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
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
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            DashboardDepositEvent(
                              TransactionModel(
                                address: addressController.text,
                                amount: int.parse(amountController.text),
                                reason: reasonController.text,
                                timestamp: DateTime.now(),
                              ),
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '+ DEPOSIT',
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
