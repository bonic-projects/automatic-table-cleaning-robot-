import 'package:scrubster/app/app.locator.dart';
import 'package:scrubster/app/app.router.dart';
import 'package:scrubster/models/movement_data.dart';
import 'package:scrubster/services/movement_database_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
//import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  // final _navigationService = locator<NavigationService>();
  final _movementDatabaseService = locator<MovementDatabaseService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_movementDatabaseService];

  // DeviceMovement? get node => _movementDatabaseService.node;

  void onModelReady() {
    _movementDatabaseService.setAuto(IsAuto(isAuto: false));
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: 's',
    ));
    _movementDatabaseService.setStepper1Data(Stepper1Movement(
      stepper1: 's',
    ));
    _movementDatabaseService.setStepper2Data(Stepper2Movement(
      stepper2: 's',
    ));
  }

  //functions for movement control

  void isForward(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  void isBackward(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  void isLeft(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  void isRight(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  void isStop(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  //functions for rotation coontrolls

  void isLeftR(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  void isRightR(String value) {
    _movementDatabaseService.setDeviceData(DeviceMovement(
      direction: value,
    ));
  }

  //functions for stepper 1 controlls
  void isStepper1up(String value) {
    _movementDatabaseService.setStepper1Data(Stepper1Movement(stepper1: 'u'));
  }

  void isStepper1down(String value) {
    _movementDatabaseService.setStepper1Data(Stepper1Movement(stepper1: 'd'));
  }

  void isStepper1stop(String value) {
    _movementDatabaseService.setStepper1Data(Stepper1Movement(stepper1: 's'));
  }

  //functions for stepper 2 controlls

  void isStepper2up(String value) {
    _movementDatabaseService.setStepper2Data(Stepper2Movement(stepper2: 'u'));
  }

  void isStepper2down(String value) {
    _movementDatabaseService.setStepper2Data(Stepper2Movement(stepper2: 'd'));
  }

  void isStepper2stop(String value) {
    _movementDatabaseService.setStepper2Data(Stepper2Movement(stepper2: 's'));
  }

  //method for Automatic button

  bool _isAuto = false;
  bool get isAuto => _isAuto;

  void isAutoButton() {
    _isAuto = !_isAuto;
    isAutomatic(_isAuto);
    _navigationService.navigateToAutomaticdataView();
  }

  void isAutomatic(bool value) {
    _movementDatabaseService.setAuto(IsAuto(isAuto: value));
  }
}

//
