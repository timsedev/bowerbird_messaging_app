import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:bowerbird_messaging_app/core/models/message_group.dart';
import 'package:bowerbird_messaging_app/services/message_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _messageService = locator<MessageService>();

  List<MessageGroup>? messageGroups;

  void onViewModelReady() async {
    await getMessageGroups();
    setBusy(false);
    notifyListeners();
  }

  Future<void> getMessageGroups() async {
    setBusy(true);
    messageGroups =
        await _messageService.getMessageGroups(_messageService.isLoggedIn);
    setBusy(false);
    notifyListeners();
  }
}
