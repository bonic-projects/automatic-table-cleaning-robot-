import 'package:scrubster/app/app.locator.dart';
import 'package:scrubster/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AutomaticdataViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void alertdialog() {
    _navigationService.navigateToAlerWidgetView();
  }
}
