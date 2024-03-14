import 'package:scrubster/app/app.locator.dart';
import 'package:scrubster/app/app.router.dart';
import 'package:scrubster/models/movement_data.dart';
import 'package:scrubster/services/movement_database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AlerWidgetViewModel extends BaseViewModel {
  final _naviigatorService = locator<NavigationService>();
  final _movementDatabaseService = locator<MovementDatabaseService>();

  

  void popPop() {
    _naviigatorService.popRepeated(1);
  }

  bool _isAuto = true;
  bool get isAuto => _isAuto;

  
  void popHome() {
     _isAuto = !_isAuto;
    autoToggle(_isAuto);
    _naviigatorService.navigateToHomeView();
  }

  void autoToggle(bool value) {
    _movementDatabaseService.setAuto(IsAuto(isAuto: value));
  }
}
