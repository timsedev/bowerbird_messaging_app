import 'package:stacked/stacked.dart';
import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:bowerbird_messaging_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future runStartupLogic() async {
    /// Temporary not checking if user is logged in
    _navigationService.replaceWithLoginView();
  }
}
