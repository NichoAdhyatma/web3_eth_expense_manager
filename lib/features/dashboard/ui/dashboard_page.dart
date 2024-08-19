import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/core/utils/sizedbox_ext.dart';
import 'package:flutter_web3/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_web3/features/deposit/ui/deposit_page.dart';
import 'package:flutter_web3/features/withdraw/ui/withdraw_page.dart';
import 'package:flutter_web3/generated/assets.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  static final route =
      MaterialPageRoute(builder: (context) => const DashboardPage());

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(DashboardInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web3 App'),
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DashboardError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (state is DashboardSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Assets.assetsEthIcon,
                              width: 50,
                              height: 50,
                            ),
                            20.widthSB,
                            Text(
                              '${state.balance} ETH',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    20.heightSB,
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(WithdrawPage.route());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[100],
                            ),
                            child: const Text(
                              "- DEBIT",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        12.widthSB,
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(DepositPage.route());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[100],
                            ),
                            child: const Text(
                              "+ CREDIT",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.heightSB,
                    Text(
                      "Transactions",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    10.heightSB,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];

                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              Assets.assetsEthIcon,
                              width: 35,
                              height: 35,
                            ),
                            title: Text(
                              '${transaction.amount} ETH',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                2.heightSB,
                                Text(
                                  transaction.address,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                2.heightSB,
                                Text(transaction.reason),
                              ],
                            ),
                            trailing: Text(
                              DateFormat.yMMMd().format(transaction.timestamp),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
