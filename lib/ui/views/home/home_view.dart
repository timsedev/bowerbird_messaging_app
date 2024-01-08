import 'package:bowerbird_messaging_app/ui/common/logo.dart';
import 'package:bowerbird_messaging_app/ui/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            _buildBasicAppBar(context, viewModel),
            _buildMessageGroupList(context, viewModel),
          ],
        ),
      ),
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

  Widget _buildBasicAppBar(BuildContext context, HomeViewModel viewModel) {
    return Container(
      color: kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: sizeM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horizontalSpaceM,
          bowerBirdLogo(size: sizeL, isDark: false),
          horizontalSpaceM,
          Text(
            'Messages',
            style: TextStyle(
              fontSize: sizeL,
              fontWeight: FontWeight.bold,
              color: kWhiteColor,
            ),
          ),
          Spacer(),
          // search icon
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          ),
          horizontalSpaceS,
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: kWhiteColor,
            ),
          ),
          horizontalSpaceM,
        ],
      ),
    );
  }

  Widget _buildMessageGroupList(BuildContext context, HomeViewModel viewModel) {
    return Expanded(
      child: viewModel.messageGroups == null
          ? const Center(child: Text('No message groups found'))
          : ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(viewModel.messageGroups![index].name),
                );
              },
              itemCount: viewModel.messageGroups!.length,
            ),
    );
  }
}
