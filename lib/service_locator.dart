import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/repositories/pill_box_set_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/repositories/pill_box_set_repository.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_bloc.dart';
import 'package:pusherman/core/presentation/converter/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() =>
      PillBoxSetBloc(
          pillBoxSetGetter: sl.get<GetPillBoxSet>(),
          inputConverter: sl.get<InputConverter>(),
      )
  );

  sl.registerLazySingleton(() => GetPillBoxSet(sl.get<PillBoxSetRepository>()));

  sl.registerLazySingleton<PillBoxSetRepository>(() =>
      PillBoxSetRepositoryImpl(
          networkInfo: sl.get<NetworkInfo>(),
          localDataSource: sl.get<PillBoxSetLocalDataSource>(),
          remoteDataSource: sl.get<PillBoxSetRemoteDataSource>(),
      )
  );

  sl.registerLazySingleton<PillBoxSetLocalDataSource>(
      () =>  PillBoxSetLocalDataSourceImpl(sharedPreferences: sl())
  );
  sl.registerLazySingleton<PillBoxSetRemoteDataSource>(
      () => PillBoxSetRemoteDataSourceImpl(client: sl.get<http.Client>())
  );

  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(sl.get<DataConnectionChecker>())
  );

  //! External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
}