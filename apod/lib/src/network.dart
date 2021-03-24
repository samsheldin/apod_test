import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(
  baseUrl: 'https://api.nasa.gov',
);


final dioInstance = Dio(options);
