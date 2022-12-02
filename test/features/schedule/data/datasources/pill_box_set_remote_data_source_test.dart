import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/organizer_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/organizer_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('OrganizerRemoteDataSource', () {
    OrganizerDataSource dataSource;
    MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = OrganizerRemoteDataSourceImpl(client: mockHttpClient);
    });

    void mockHttpGetWithStatus(status) {
      final body = status == 200 ? fixtureAsString('coda_organizer.json') : 'Boom!';

      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(body, status),
      );
    }

    group('getByDependent', () {
      test('calls with correct URI and headers', () async {
        // given
        mockHttpGetWithStatus(200);
        final aDependent = 'Coda';

        // when
        await dataSource.getByDependent(aDependent);

        // then
        verify(mockHttpClient.get(
          'http://localhost:8000/dependent/Coda',
          headers: {'Content-Type': 'application/json'},
        ));
      });

      test('returns a Organizer', () async {
        // given
        mockHttpGetWithStatus(200);
        final aDependent = 'Coda';
        final expectedOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));

        // when
        final result = await dataSource.getByDependent(aDependent);

        // then
        expect(result, equals(expectedOrganizer));
      });

      test('throws a ServerException when the response code is other than 200', () async {
        // given
        mockHttpGetWithStatus(404);
        final aDependent = 'Coda';

        // when
        final call = dataSource.getByDependent;

        // then
        expect(() => call(aDependent), throwsA(TypeMatcher<ServerException>()));
      });
    });

    group('PUT', () {
      test('puts with correct URI and headers', () async {
        // given
        var expectedUrl = 'http://localhost:8000/dependent/Coda';
        Map<String, String> expectedHeaders = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
        final givenOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));
        final expectedJsonString = json.encode(givenOrganizer);
        when(mockHttpClient.update(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(expectedJsonString, 201),
        );

        // when
        await dataSource.update(givenOrganizer);

        // then
        verify(mockHttpClient.update(
          expectedUrl,
          body: expectedJsonString,
          headers: expectedHeaders,
        ));
      });

      test('creates a Organizer', () async {
        // given
        var expectedUrl = 'http://localhost:8000/dependent/Coda';
        Map<String, String> expectedHeaders = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
        final givenOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));
        final expectedJsonString = json.encode(givenOrganizer);
        when(mockHttpClient.update(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(expectedJsonString, 201),
        );

        // when
        await dataSource.update(givenOrganizer);

        // then
        verify(mockHttpClient.update(
          expectedUrl,
          body: expectedJsonString,
          headers: expectedHeaders,
        ));
      });

      // test('updates a Organizer', () async {
      //   // given
      //   final givenOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));
      //   final expectedJsonString = json.encode(givenOrganizer);
      //
      //   // when
      //   await dataSource.put(givenOrganizer);
      //
      //   // then
      //   verify(mockSharedPreferences.setString(
      //     CACHED_PILL_BOX_SET + givenOrganizer.dependent,
      //     expectedJsonString,
      //   ));
      // });

      // test('fails to create/update', () async {
      //   // given
      //   final givenOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));
      //   final expectedJsonString = json.encode(givenOrganizer);
      //
      //   // when
      //   await dataSource.put(givenOrganizer);
      //
      //   // then
      //   verify(mockSharedPreferences.setString(
      //     CACHED_PILL_BOX_SET + givenOrganizer.dependent,
      //     expectedJsonString,
      //   ));
      // });
    });
  });
}
