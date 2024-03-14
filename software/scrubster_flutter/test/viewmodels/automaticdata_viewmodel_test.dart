import 'package:flutter_test/flutter_test.dart';
import 'package:scrubster/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AutomaticdataViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
