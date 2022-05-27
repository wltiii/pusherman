import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';

import 'user_data_source.dart';

// TODO: SEE: https://stackoverflow.com/questions/47372568/how-to-point-to-localhost8000-with-the-dart-http-package-in-flutter
const BASE_HOST_URI = 'localhost:8000';
const CARETAKER_PATH = 'caretaker';

class CaretakerRemoteDataSourceImpl implements UserDataSource {
  final http.Client client;

  CaretakerRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<CaretakerModel> get(String caretaker) async {
    final uri = new Uri.http(BASE_HOST_URI, '/$CARETAKER_PATH/$caretaker');
    final headers = {'Content-Type': 'application/json'};
    final response = await client.get(
      uri.toString(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return CaretakerModel.fromJson(json.decode(response.body));
    }

    throw ServerException();
  }

  @override
  Future<void> put(CaretakerModel caretaker) async {
    final uri =
        new Uri.http(BASE_HOST_URI, '/$CARETAKER_PATH/${caretaker.name}');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = json.encode(caretaker.toJson());
    print('url=${uri.toString()}');
    print('body=$body');
    print('headers=$headers');

    var response = await client.put(
      uri.toString(),
      body: body,
      headers: headers,
    );

    return response;
  }
}
