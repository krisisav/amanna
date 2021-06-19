// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/api.dart' as _i3;
import '../database/database.dart' as _i4;
import '../repositories/db_quote_repository.dart' as _i6;
import '../repositories/quote_repository.dart' as _i5;
import '../sync/quote_synchronizer.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.API>(_i3.API());
  gh.singleton<_i4.DatabaseProvider>(_i4.DatabaseProvider());
  gh.singleton<_i5.QuoteRepository>(
      _i6.DbQuoteRepository(get<_i4.DatabaseProvider>()),
      instanceName: 'sqlite');
  gh.singleton<_i7.QuoteSynchronizer>(_i7.QuoteSynchronizer(
      get<_i3.API>(), get<_i5.QuoteRepository>(instanceName: 'sqlite')));
  return get;
}
