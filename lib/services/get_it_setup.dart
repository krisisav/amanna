import 'package:amanna/api/api.dart';
import 'package:amanna/database/database.dart';
import 'package:amanna/repositories/db_quote_repository.dart';
import 'package:amanna/repositories/quote_repository.dart';
import 'package:amanna/sync/quote_synchronizer.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'get_it_setup.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)

@injectableInit
void configureDependencies() => $initGetIt(getIt);

// void setupGetIt() {
//   getIt.registerSingleton<API>(API());
//   getIt.registerSingleton<DatabaseProvider>(DatabaseProvider());
//   getIt.registerSingleton<QuoteRepository>(DbQuoteRepository());
//   getIt.registerSingleton<QuoteSynchronizer>(QuoteSynchronizer(api, quoteRepository));
// }