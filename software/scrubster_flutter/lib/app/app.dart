import 'package:scrubster/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:scrubster/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:scrubster/ui/views/home/home_view.dart';
import 'package:scrubster/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scrubster/services/movement_database_service.dart';
import 'package:scrubster/ui/views/automaticdata/automaticdata_view.dart';
import 'package:scrubster/ui/views/aler_widget/aler_widget_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AutomaticdataView),
    MaterialRoute(page: AlerWidgetView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: MovementDatabaseService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
