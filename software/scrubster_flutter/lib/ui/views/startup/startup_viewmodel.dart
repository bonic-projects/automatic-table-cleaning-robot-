import 'package:stacked/stacked.dart';
import 'package:scrubster/app/app.locator.dart';
import 'package:scrubster/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.logger.dart';
import '../../../services/movement_database_service.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartupViewModel');
  final _navigationService = locator<NavigationService>();
  final _dbService = locator<MovementDatabaseService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    log.i("df");
    _dbService.setupNodeListening();
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _navigationService.replaceWithHomeView();
  }
}
