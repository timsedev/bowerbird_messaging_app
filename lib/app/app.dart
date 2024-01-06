import 'package:bowerbird_messaging_app/ui/views/home/home_view.dart';
import 'package:bowerbird_messaging_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bowerbird_messaging_app/ui/views/login/login_view.dart';
import 'package:bowerbird_messaging_app/services/auth_service.dart';
import 'package:bowerbird_messaging_app/services/message_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: MessageService),
// @stacked-service
  ],
)
class App {}