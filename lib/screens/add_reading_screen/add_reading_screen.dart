import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bp_cubit/bp_cubit.dart';
import '../../models/blood_pressure_reading.dart';
import 'cubit/add_reading_cubit.dart';

class AddReadingScreen extends StatelessWidget {
  const AddReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddReadingCubit(),
      // BlocConsumer is great for reacting to state changes (like showing a dialog)
      // while BlocBuilder is for rebuilding UI. Here, we only need to build.
      child: BlocBuilder<AddReadingCubit, AddReadingState>(
        builder: (context, state) {
          // The UI is now much cleaner. It only needs to display what the state tells it.
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: const Text("Add a Measurement"),
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // This reminder container is perfect as is.
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade300, width: 1.5),
                      ),
                      child: const Text(
                        'Reminder: to get accurate results, measure your blood pressure in a calm state, while sitting and relaxed.',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: 'Systolic',
                            onChanged: (value) => context
                                .read<AddReadingCubit>()
                                .systolicChanged(int.tryParse(value) ?? 0),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: 'Diastolic',
                            onChanged: (value) => context
                                .read<AddReadingCubit>()
                                .diastolicChanged(int.tryParse(value) ?? 0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Pulse',
                      onChanged: (value) => context
                          .read<AddReadingCubit>()
                          .pulseChanged(int.tryParse(value) ?? 0),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) =>
                          context.read<AddReadingCubit>().noteChanged(value),
                    ),

                    // NEW: Error message display area
                    // This widget only appears if there's an error message in the state.
                    if (state.errorMessage != null && state.status == FormStatus.invalid) ...[
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage!,
                        style: TextStyle(color: Colors.red.shade700, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          // Dim the button when it's disabled for better UX
                          disabledBackgroundColor: Colors.grey.shade400,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // The logic is now beautifully simple: is the state valid?
                        onPressed: state.isFormValid
                            ? () {
                          final timestamp = DateTime.now();
                          context.read<BPCubit>().addReading(
                            BloodPressureReading(
                              systolic: state.systolic,
                              diastolic: state.diastolic,
                              pulse: state.pulse,
                              note: state.note,
                              timestamp: timestamp,
                            ),
                          );
                          // A little feedback for the user can be nice
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reading saved successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                            : null, // Button is disabled if form is not valid
                        child: const Text('Add Reading'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to reduce code duplication for TextFields
  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}