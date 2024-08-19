part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialFetchEvent extends DashboardEvent {}

class DashboardDepositEvent extends DashboardEvent {
  final TransactionModel transactionModel;

  DashboardDepositEvent(this.transactionModel);
}

class DashboardWithdrawEvent extends DashboardEvent {
  final TransactionModel transactionModel;

  DashboardWithdrawEvent(this.transactionModel);
}