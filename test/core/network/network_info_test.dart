import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/core/network/network_info.dart';

class MockNetworkInfo implements NetworkInfo {
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => throw UnimplementedError();
}

void main() {
  NetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection', () async {
        // given
        final givenConnectionFuture = Future.value(true);

//        when(mockDataConnectionChecker.hasConnection)
//            .thenAnswer((_) => tHasConnectionFuture);
        // when
        final result = networkInfo.isConnected;
        // then
//        verify(mockDataConnectionChecker.hasConnection);
        expect(result, givenConnectionFuture);
      },
    );
  });
}
