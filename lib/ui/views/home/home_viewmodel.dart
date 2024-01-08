import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:bowerbird_messaging_app/app/app.router.dart';
import 'package:bowerbird_messaging_app/core/models/message.dart';
import 'package:bowerbird_messaging_app/core/models/message_group.dart';
import 'package:bowerbird_messaging_app/services/auth_service.dart';
import 'package:bowerbird_messaging_app/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _messageService = locator<MessageService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final searchController = TextEditingController();

  List<MessageGroup>? messageGroups;

  bool isSearching = false;

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      searchController.clear();
    }
    notifyListeners();
  }

  void onSubmitted(String input) {
    isSearching = false;
    // TODO: Implement search
    notifyListeners();
  }

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

  void logout() {
    _authService.logout();
    _navigationService.replaceWithLoginView();
    notifyListeners();
  }
}
