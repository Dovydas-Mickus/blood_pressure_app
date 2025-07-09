part of 'add_reading_cubit.dart';

// An enum to represent the overall status of the form
enum FormStatus { initial, invalid, valid }

class AddReadingState extends Equatable {
  final int systolic;
  final int diastolic;
  final int pulse;
  final String note;
  // We don't need the timestamp in the form state, it's added on submission.

  // New properties for validation!
  final FormStatus status;
  final String? errorMessage;

  const AddReadingState({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.note,
    required this.status,
    this.errorMessage,
  });

  // A handy getter to make the UI code cleaner
  bool get isFormValid => status == FormStatus.valid;

  @override
  List<Object?> get props => [systolic, diastolic, pulse, note, status, errorMessage];

  AddReadingState copyWith({
    int? systolic,
    int? diastolic,
    int? pulse,
    String? note,
    FormStatus? status,
    String? errorMessage,
  }) {
    return AddReadingState(
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      note: note ?? this.note,
      status: status ?? this.status,
      // We can intentionally clear the error message by passing null
      errorMessage: errorMessage,
    );
  }
}