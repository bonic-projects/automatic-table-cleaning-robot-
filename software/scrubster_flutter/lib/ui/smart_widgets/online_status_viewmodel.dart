import 'dart:async';

import 'package:scrubster/models/movement_data.dart';
import 'package:scrubster/services/movement_database_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../app/app.logger.dart';



class HomeViewModel extends BaseViewModel {
 final log = getLogger('StatusWidget');

  final _dbService = locator<MovementDatabaseService>();

  DeviceMovement? get node => _dbService.node;

  bool _isOnline = false;

  bool get isOnline => _isOnline;

  bool isOnlineCheck(DateTime? time) {
    if (time == null) return false;
    final DateTime now = DateTime.now();
    final difference = now.difference(time).inSeconds;
    log.i("Status $difference");
    return difference.abs() <= 5;
  }

  late Timer timer;

  void setTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        _isOnline = isOnlineCheck(node?.lastSeen);
        notifyListeners();
      },
    );
  }
}
