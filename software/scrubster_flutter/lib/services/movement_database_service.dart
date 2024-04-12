import 'package:firebase_database/firebase_database.dart';
import 'package:scrubster/models/movement_data.dart';
import 'package:stacked/stacked.dart';

const dbCode = "85kYB1QKFIZVrEMwVPsPDUSxYX33";

class MovementDatabaseService with ListenableServiceMixin {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  DeviceMovement? _node;
  DeviceMovement? get node => _node;

  void setupNodeListening() {
    DatabaseReference starCountRef = _db.ref('/devices/$dbCode/data');

    try {
      starCountRef.onValue.listen((DatabaseEvent event) {
        if (event.snapshot.exists) {
          _node = DeviceMovement.fromMap(event.snapshot.value as Map);
             print(_node?.lastSeen); //data['time']
          notifyListeners();
        }
      });
    } catch (e) {
      //  log.e("Error: $e");
    }
  }

  void setDeviceData(DeviceMovement data) {
    DatabaseReference dataRef = _db.ref('/devices/$dbCode/data');
    dataRef.update(data.toJson());
  }

  void setStepper1Data(Stepper1Movement data) {
    DatabaseReference dataRef = _db.ref('/devices/$dbCode/data');
    dataRef.update(data.toJson());
  }

  void setStepper2Data(Stepper2Movement data) {
    DatabaseReference dataRef = _db.ref('/devices/$dbCode/data');
    dataRef.update(data.toJson());
  }

  void setAuto(IsAuto data) {
    DatabaseReference dataRef = _db.ref('/devices/$dbCode/data');
    dataRef.update(data.tojson());
  }
}
