import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/infrastructure/datasources/organizer_data_source.dart';

// TODO: SEE: https://stackoverflow.com/questions/47372568/how-to-point-to-localhost8000-with-the-dart-http-package-in-flutter
const BASE_HOST_URI = 'localhost:8000';
const DEPENDENT_PATH = 'dependent';

class OrganizerRemoteDataSourceImpl implements OrganizerDataSource {
  final http.Client client;

  OrganizerRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<Organizer> getByDependent(Dependent dependent) async {
    final uri = new Uri.http(BASE_HOST_URI, '/$DEPENDENT_PATH/$dependent');
    final headers = {'Content-Type': 'application/json'};
    final response = await client.get(
      uri.toString(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Organizer.fromJson(json.decode(response.body));
    }

    throw NotFoundException();
  }

  @override
  Future<void> put(Organizer organizer) async {
    final uri =
        new Uri.http(BASE_HOST_URI, '/$DEPENDENT_PATH/${Organizer.dependent}');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = json.encode(Organizer.toJson());
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