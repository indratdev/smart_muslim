import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_muslim/helpers/routes.dart';
import 'package:smart_muslim/state_managements/bloc/bloc/location_bloc.dart';
import 'package:smart_muslim/state_managements/bloc/praybloc/pray_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc()..add(GetLocationEvent()),
        ),
        BlocProvider(create: (context) => PrayBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes().getRoutes(),
      ),
    );
  }
}
