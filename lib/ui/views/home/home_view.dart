import 'package:bowerbird_messaging_app/core/models/message_group.dart';
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
      padding: const EdgeInsets.symmetric(vertical: sizeL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horizontalSpaceM,
          bowerBirdLogo(size: sizeL, isDark: false),
          horizontalSpaceM,
          const Text(
            'Messages',
            style: TextStyle(
              fontSize: sizeL,
              fontWeight: FontWeight.bold,
              color: kWhiteColor,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: viewModel.toggleSearch,
            child: const Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          ),
          horizontalSpaceS,
          PopupMenuButton<int>(
            child: const Icon(
              Icons.more_vert,
              color: kWhiteColor,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("Sign out"),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 1:
                  viewModel.logout();
                  break;
                default:
                  break;
              }
            },
          ),
          horizontalSpaceM,
        ],
      ),
    );
  }

  Widget _buildMessageGroupList(BuildContext context, HomeViewModel viewModel) {
    return Expanded(
      child: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () async {
          await viewModel.getMessageGroups();
        },
        child: viewModel.messageGroups == null
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Column(
                    children: [
                      Expanded(
                          child:
                              Center(child: Text('No message groups found'))),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: size5XL,
                    width: double.infinity,
                    child: _buildMessageGroupItem(
                      context,
                      viewModel,
                      viewModel.messageGroups![index],
                    ),
                  );
                },
                itemCount: viewModel.messageGroups!.length,
              ),
      ),
    );
  }

  Widget _buildMessageGroupItem(BuildContext context, HomeViewModel viewModel,
      MessageGroup messageGroup) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sizeM, horizontal: sizeS),
      child: Row(children: [
        Container(
          height: size3XL,
          width: size3XL,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [kGreyColor, kDarkAccentColor, kPrimaryColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        horizontalSpaceM,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      messageGroup.name,
                      style: const TextStyle(
                        fontSize: sizeM,
                        fontWeight: kFontWeightBold,
                      ),
                    ),
                  ),
                  Text(
                    _lastMessageTime(messageGroup.lastMessageAt),
                    style: const TextStyle(
                      fontSize: sizeS,
                      fontWeight: kFontWeightRegular,
                      color: kGreyColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit adipicsing timothy',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: sizeM,
                        fontWeight: kFontWeightRegular,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  horizontalSpaceM,
                  Container(
                    padding: const EdgeInsets.all(sizeXS),
                    decoration: const BoxDecoration(
                      color: kAccentColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        fontSize: sizeS,
                        fontWeight: kFontWeightBold,
                        color: kDarkAccentColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  _lastMessageTime(DateTime? lastMessageAt) {
    if (lastMessageAt == null) {
      return '';
    }

    final now = DateTime.now();
    final difference = now.difference(lastMessageAt);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
