import 'package:flutter_bloc/flutter_bloc.dart';

enum StateStatus {
  initial,
  loading,
  data,
  error,
  leave,
}

extension StateStatusIs on StateStatus {
  bool get isInitial => this == StateStatus.initial;
  bool get isData => this == StateStatus.data;
  bool get isLoading => this == StateStatus.loading;
  bool get isError => this == StateStatus.error;
}

extension CubitExt<T> on Cubit<T> {
  void emitSafe(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}

extension BlocExt<T> on BlocBase<T> {
  void emitSafe(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}
