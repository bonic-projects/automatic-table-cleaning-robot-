/// Device Movement data Model
class DeviceMovement {
  String? direction;
  DateTime? lastSeen;

  //

  DeviceMovement({required this.direction, this.lastSeen});

//
  factory DeviceMovement.fromMap(Map data) {
    return DeviceMovement(
      direction: data['direction'],
      lastSeen: DateTime.fromMillisecondsSinceEpoch(data['ts']),
    );
  }

  //
  Map<String, dynamic> toJson() => {
        'direction': direction,
      };
}

//model class for stepper 1
class Stepper1Movement {
  String? stepper1;

  Stepper1Movement({
    required this.stepper1,
  });

//
  factory Stepper1Movement.fromMap(Map data) {
    return Stepper1Movement(
      stepper1: data['stepper1'],
    );
  }

  //
  Map<String, dynamic> toJson() => {
        'stepper1': stepper1,
      };
}

//model class for stepper 2
class Stepper2Movement {
  String? stepper2;

  Stepper2Movement({
    required this.stepper2,
  });

//
  factory Stepper2Movement.fromMap(Map data) {
    return Stepper2Movement(
      stepper2: data['stepper2'],
    );
  }

  //
  Map<String, dynamic> toJson() => {
        'stepper2': stepper2,
      };
}

class IsAuto {
  bool isAuto;

  IsAuto({
    required this.isAuto,
  });

  factory IsAuto.fromMap(Map data) {
    return IsAuto(isAuto: data['isAuto']);
  }

  Map<String, dynamic> tojson() => {
        'isAuto': isAuto,
      };
}
