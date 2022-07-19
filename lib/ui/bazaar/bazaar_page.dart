import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jumblemoll/data/repository/user/user_repository.dart';

import '../../data/repository/auth/auth_repository.dart';
import '../../data/repository/bazaar/bazaar_repository_impal.dart';
import '../../ui/bazaar/widget/bazaar_list.dart';
import '../common/drawer.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_media_query.dart';
import '../hooks/use_router.dart';
import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';
import 'bazaar_view_model.dart';

class BazaarListPage extends HookConsumerWidget {
  const BazaarListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final appMQ = useMediaQuery();
    final state = ref.watch(bazaarViewModelProvider);
    final viewModel = ref.watch(bazaarViewModelProvider.notifier);
    final l10n = useL10n();
    final appRoute = useRouter();
    final asyncValue = ref.watch(bazaarListStreamProvider);
    final user = ref.watch(userRepositoryProvider);

    var organizer = useState<bool>(false);

    final authState = ref.watch(authStateProvider);
    authState.whenData(
      (data) async {
        // print(data!.uid);
        if (data != null) {
          final result = (await user.fetchBankStatus(data.uid));
          if (result == 'verified') {
            organizer.value = true;
          } else {
            organizer.value = false;
          }
        }
      },
    );
    // const supporter = true; // c
    return asyncValue.when(
      data: (data) {
        return Scaffold(
          // backgroundColor: theme.appColors.background,
          // appBar: TopHeader(title: 'All Event'),
          body: SafeArea(
            child: Row(
              children: [
                appMQ.size.width > 768 ? const CustomDrawer() : Container(),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: appMQ.size.width >= 768 ? 600 : null,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          viewModel.readBazaar();
                        },
                        child: data.isNotEmpty
                            ? ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                // itemExtent: 100,
                                itemCount: data.length,
                                itemBuilder: (_, index) {
                                  final bazaar = data[index];
                                  return EventCard(
                                      index: index, bazaar: bazaar);
                                },
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Visibility(
            visible: organizer.value,
            child: FloatingActionButton(
              // backgroundColor: theme.appColors.primary,
              // foregroundColor: theme.appColors.onPrimary,
              onPressed: () async {
                appRoute.push(const BazaarAddRoute());
              },
              child: const Icon(Icons.add_sharp),
            ),
          ),
        );
      },
      error: (e, msg) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(
                e.toString(),
                style: theme.textTheme.h30,
              ),
            ),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                  // color: theme.appColors.primary,
                  ),
            ),
          ),
        );
      },
    );
  }
}
