import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_reading_state.dart';

class AddReadingCubit extends Cubit<AddReadingState> {
  // The initial state now includes the form status
  AddReadingCubit()
      : super(const AddReadingState(
    systolic: 0,
    diastolic: 0,
    pulse: 0,
    note: '',
    status: FormStatus.initial,
  ));

  void systolicChanged(int value) {
    // We create a temporary new state and then validate it
    _validateState(state.copyWith(systolic: value));
  }

  void diastolicChanged(int value) {
    _validateState(state.copyWith(diastolic: value));
  }

  void pulseChanged(int value) {
    _validateState(state.copyWith(pulse: value));
  }

  void noteChanged(String value) {
    // Notes don't need validation, so we can emit directly
    emit(state.copyWith(note: value));
  }

  // This is the new "brain" of the Cubit
  void _validateState(AddReadingState newState) {
    // Rule 1: All core values must be entered
    if (newState.systolic <= 0 || newState.diastolic <= 0 || newState.pulse <= 0) {
      // Don't show an error yet, the user is still typing. Just keep the form invalid.
      emit(newState.copyWith(status: FormStatus.initial));
      return;
    }

    // Rule 2: Basic medical logic check
    if (newState.systolic <= newState.diastolic) {
      emit(newState.copyWith(
        status: FormStatus.invalid,
        errorMessage: 'Systolic pressure must be higher than diastolic.',
      ));
      return;
    }

    // Rule 3: Plausibility check for typos
    if (newState.systolic > 300 || newState.diastolic > 200 || newState.pulse > 250) {
      emit(newState.copyWith(
        status: FormStatus.invalid,
        errorMessage: 'Please check for typos and enter a realistic value.',
      ));
      return;
    }

    // If all rules pass, the form is valid!
    emit(newState.copyWith(
      status: FormStatus.valid,
      errorMessage: null, // Clear any previous errors
    ));
  }
}