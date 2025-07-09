import 'package:bp_tacking/bp_cubit/bp_cubit.dart';
import 'package:bp_tacking/models/blood_pressure_reading.dart';
import 'package:bp_tacking/repositories/database_repository.dart';
import 'package:bp_tacking/screens/home_screen/home_screen.dart';
import 'package:bp_tacking/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BloodPressureReadingAdapter());

  final box = await Hive.openBox<BloodPressureReading>('readings');

  runApp(RepositoryProvider(
    create: (context) => DatabaseRepository(box),
    child: BlocProvider(
      create: (context) => BPCubit(context.read<DatabaseRepository>()),
      child: MaterialApp(
        theme: AppTheme.appTheme,

      home: HomeScreen(),
      ),
    ),
  ));
}
