import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';
import 'package:pusherman/core/network/network_info.dart';

@GenerateMocks([InternetConnectionChecker])

void main() {
  var mockInternetConnectionChecker = MockInternetConnectionChecker();
  NetworkInfo networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);

  group('isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // given
        final givenConnectionFuture = Future.value(true);

        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => givenConnectionFuture);

        // when
        final result = networkInfo.isConnected;

        // then
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, givenConnectionFuture);
      },
    );
  });
}