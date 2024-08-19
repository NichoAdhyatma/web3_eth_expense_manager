import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/core/themes/app_theme.dart';
import 'package:flutter_web3/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_web3/features/dashboard/ui/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const DashboardPage(),
      ),
    );
  }
}
