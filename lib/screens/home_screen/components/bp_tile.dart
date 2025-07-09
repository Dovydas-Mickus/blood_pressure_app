import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bp_cubit/bp_cubit.dart';
import '../../../models/blood_pressure_reading.dart';

class BPTile extends StatelessWidget {
  // We only need the reading. Index and Cubit are no longer needed.
  final BloodPressureReading reading;

  const BPTile({
    super.key,
    required this.reading,
  });

  @override
  Widget build(BuildContext context) {
    // Hide the notes section if the note is empty for a cleaner look
    final hasNote = reading.note != null && reading.note!.isNotEmpty;

    return ExpansionTile(
      // --- YOUR STYLING RESTORED ---
      showTrailingIcon: false,
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.zero,
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('yyyy-MM-dd').format(reading.timestamp),
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                DateFormat('HH:mm').format(reading.timestamp),
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
      subtitle: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 230;

          final pressureRow = Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green[600],
                ),
                child: Text(
                  reading.systolic.toString(),
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text('/', style: TextStyle(fontSize: 30)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueGrey[700],
                ),
                child: Text(
                  reading.diastolic.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );

          final pulseBox = Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red[900],
            ),
            child: Text(
              'PUL ${reading.pulse}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          );

          return Padding(
            padding: const EdgeInsets.only(top: 8.0), // A little spacing
            child: isNarrow
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pressureRow,
                const SizedBox(height: 8),
                pulseBox,
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [pressureRow, pulseBox],
            ),
          );
        },
      ),
      // --- END OF RESTORED STYLING ---
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Only show the Notes section if there is a note
              if (hasNote) ...[
                const Text(
                  'Notes:',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reading.note!,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
              ],
              // Use a standard, accessible button for the delete action
              ElevatedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete Measurement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                // Call the safe delete dialog
                onPressed: () => _showDeleteConfirmationDialog(context, reading.key),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method for the safe delete confirmation
  void _showDeleteConfirmationDialog(BuildContext context, dynamic readingKey) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Reading?'),
        content: const Text('This action is permanent and cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Read the cubit from context and delete by KEY, not index
              context.read<BPCubit>().deleteReading(readingKey);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}