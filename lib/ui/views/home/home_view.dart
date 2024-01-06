import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:bowerbird_messaging_app/ui/common/app_colors.dart';
import 'package:bowerbird_messaging_app/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BowerBird Messaging App'),
      ),
      body: SafeArea(
          child: viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : _buildMessageGroupList(context, viewModel)),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.setBusy(true);
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  Widget _buildMessageGroupList(BuildContext context, HomeViewModel viewModel) {
    return viewModel.messageGroups == null
        ? const Center(child: Text('No message groups found'))
        : ListView.builder(
            itemCount: viewModel.messageGroups!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(viewModel.messageGroups![index].name),
                ),
              );
            },
          );
  }
}
