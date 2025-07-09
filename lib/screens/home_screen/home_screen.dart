import 'package:bp_tacking/bp_cubit/bp_cubit.dart';
import 'package:bp_tacking/screens/add_reading_screen/add_reading_screen.dart';
import 'package:bp_tacking/screens/home_screen/components/bp_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/blood_pressure_reading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BPCubit, BPState>(
      builder: (context, state) {
        final cubit = context.read<BPCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('BP Tracker'),
          ),
          body: ListView.builder(
            itemCount: state.readings.length,
            itemBuilder: (context, index) {
              final reading = state.readings[state.readings.length - 1 - index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                  ),
                ),
                child: BPTile(reading: reading),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => AddReadingScreen())
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
