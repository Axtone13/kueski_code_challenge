import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/language/language_event.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/language/language_state.dart';


class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(const Locale('es'))) {
    on<ChangeLanguage>((event, emit) {
      emit(LanguageState(event.locale));
    });
  }
}
