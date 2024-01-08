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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                title: const Text('BowerBird'),
                pinned: true,
                floating: true,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('BowerBird'),
                  background: Container(
                    color: Colors.blue,
                  ),
                )),
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

  Widget _buildAppBar(BuildContext context, HomeViewModel viewModel) {
    return Row();
  }

  Widget _buildMessageGroupList(BuildContext context, HomeViewModel viewModel) {
    return viewModel.messageGroups == null
        ? SliverToBoxAdapter(
            child: const Center(child: Text('No message groups found')))
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text(viewModel.messageGroups![index].name),
              ),
              childCount: viewModel.messageGroups!.length,
            ),
          );
  }
}
