part of 'homecubit_cubit.dart';

class HomeCubitState {
  final bool isLoading;
  final bool isError;
  final bool isLoaded;
  final String error;
  final APODModel apod;
  final String date;

  HomeCubitState({
    @required this.isLoading,
    @required this.isError,
    @required this.isLoaded,
    this.error,
    this.apod,
    this.date,
  });

  factory HomeCubitState.uninitialized() {
    return HomeCubitState(
        isError: false,
        isLoading: true,
        isLoaded: false,
        error: '',
        date: '',
        apod: null);
  }

  HomeCubitState update(
      {bool isError,
      bool isLoading,
      bool isLoaded,
      String error,
      String date,
      APODModel apod}) {
    return HomeCubitState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
      apod: apod ?? this.apod,
      date: date ?? this.date,
    );
  }
}
