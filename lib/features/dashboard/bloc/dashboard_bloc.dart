import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/models/transaction_model.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<TransactionModel> transactions = [];
  Web3Client? _client;
  late ContractAbi _abiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;
  int balance = 0;

  late DeployedContract _deployedContract;

  late ContractFunction _deposit;
  late ContractFunction _withdraw;
  late ContractFunction _getBalance;
  late ContractFunction _getAllTransactions;

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialFetchEvent>(dashboardInitialFetchEvent);
    on<DashboardDepositEvent>(dashboardDepositEvent);
    on<DashboardWithdrawEvent>(dashboardWithdrawEvent);
  }

  FutureOr<void> dashboardInitialFetchEvent(
    DashboardInitialFetchEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    try {
      const String rpcUrl = "http://192.168.187.59:7545";

      const String socketUrl = "ws://192.168.187.59:7545";

      const String privateKey =
          '0xb52019f9891a725af0e4eda4098995f29caf18067592d7f4a8382fc9a8768a33';

      _client = Web3Client(
        rpcUrl,
        http.Client(),
        socketConnector: () {
          return IOWebSocketChannel.connect(socketUrl).cast<String>();
        },
      );

      final abiFile = await rootBundle
          .loadString('build/contracts/ExpenseManagerContract.json');

      final abi = jsonDecode(abiFile)['abi'];

      _abiCode =
          ContractAbi.fromJson(jsonEncode(abi), 'ExpenseManagerContract');

      _contractAddress =
          EthereumAddress.fromHex('0x7783f8Db8896da51523D0fFe502c5e4CB6F7ba9F');

      _credentials = EthPrivateKey.fromHex(privateKey);

      _deployedContract = DeployedContract(_abiCode, _contractAddress);
      _deposit = _deployedContract.function('deposit');
      _withdraw = _deployedContract.function('withdraw');
      _getBalance = _deployedContract.function('getBalance');
      _getAllTransactions = _deployedContract.function('getAllTransactions');

      final transactionsData = await _client!.call(
        contract: _deployedContract,
        function: _getAllTransactions,
        params: [],
      );
      final balanceData = await _client!.call(
        contract: _deployedContract,
        function: _getBalance,
        params: [
          EthereumAddress.fromHex('0xdcB0fCeed7aB5C643beBAeA4cD38e9c721F0d9dD')
        ],
      );

      print(transactions);
      print(balance);

      List<TransactionModel> trans = [];

      for (var i = 0; i < transactionsData[0].length; i++) {
        TransactionModel transaction = TransactionModel(
          amount: transactionsData[1][i].toInt(),
          reason: transactionsData[2][i],
          address: transactionsData[0][i],
          timestamp:
              DateTime.fromMicrosecondsSinceEpoch(transactionsData[3][i].toInt()),
        );

        trans.add(transaction);
      }

      transactions = trans;

      int bal = balanceData[0].toInt();

      balance = bal;

      emit(DashboardSuccess(transactions: transactions, balance: balance));
    } catch (e) {
      print(e);
      emit(DashboardError());
    }
  }

  FutureOr<void> dashboardDepositEvent(
      DashboardDepositEvent event, Emitter<DashboardState> emit) async {
    final data = await _client!.call(
      contract: _deployedContract,
      function: _deposit,
      params: [
        event.transactionModel.amount,
        event.transactionModel.reason,
      ],
    );

    print(data);
  }

  FutureOr<void> dashboardWithdrawEvent(
      DashboardWithdrawEvent event, Emitter<DashboardState> emit) async {
    final data = await _client!.call(
      contract: _deployedContract,
      function: _withdraw,
      params: [
        event.transactionModel.amount,
        event.transactionModel.reason,
      ],
    );

    print(data);
  }
}
