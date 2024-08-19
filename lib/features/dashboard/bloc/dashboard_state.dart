part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final List<TransactionModel> transactions;
  final int balance;

  DashboardSuccess({
    required this.transactions,
    required this.balance,
  });
}

final class DashboardError extends DashboardState {}
