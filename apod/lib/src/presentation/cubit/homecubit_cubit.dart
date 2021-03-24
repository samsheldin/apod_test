import 'dart:convert';

import 'package:apod/src/domain/entitties/apod_data_model.dart';
import 'package:apod/src/network.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'homecubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeCubitState.uninitialized());

  getData({String date = ''}) async {
    emit(state.update(isLoading: true, isError: false, error: '', date: date));
    try {
      Response<String> response =
          await dioInstance.get('/planetary/apod', queryParameters: {
        'api_key': 'aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw',
        'date': (state.date == '')
            ? DateFormat("yyyy-MM-dd").format(DateTime.now())
            : state.date
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        emit(state.update(
            isLoading: false, isLoaded: true, apod: APODModel.fromJson(data)));
      } else {
        emit(state.update(
            isLoaded: false, isError: true, error: response.statusMessage));
      }
    } catch (e) {
      if (e is DioError)
        emit(state.update(
            isLoading: false,
            isError: true,
            error: json.decode(e.response.data)['msg']));
      else
        emit(
            state.update(isLoading: false, isError: true, error: e.toString()));
      if (state.apod != null) {
        emit(state.update(isLoaded: true, isError: false));
      }
    }
  }
}
