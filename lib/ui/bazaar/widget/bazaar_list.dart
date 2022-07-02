import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/bazaar/bazaar_model.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../common/show_dialog.dart';
import '../../hooks/use_l10n.dart';
import '../../hooks/use_router.dart';
import '../../routes/app_route.gr.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_theme.dart';
import '../bazaar_view_model.dart';

class EventCard extends HookConsumerWidget {
  EventCard({Key? key, required this.index, required this.bazaar})
      : super(key: key);
  int index;
  Bazaar bazaar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final viewModel = ref.watch(bazzarViewModelProvider.notifier);

    //
    var uid = 'test';
    var name = '名無し';
    var supporter = false;
    final authState = ref.watch(authStateProvider);
    authState.whenData(
      (data) {
        if (data != null) {
          uid = data.uid;
          if (data.displayName != null) {
            name = data.displayName!;
          }
          name = data.email!;
          supporter = true;
        }
      },
    );
    return Card(
      // color: theme.appColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(10.0),
      elevation: 30.0,
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.5),
                borderRadius: BorderRadius.circular(10),
                image: bazaar.pictureURL != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(bazaar.pictureURL as String),
                      )
                    : null,
              ),
              child: bazaar.pictureURL == null
                  ? Center(
                      child: Text('NoImage', style: theme.textTheme.h20
                          // .copyWith(color: theme.appColors.onPrimary),
                          ),
                    )
                  : null,
            ),
            title:
                Text(bazaar.name.toString(), style: theme.textTheme.h30.bold()
                    // .copyWith(color: theme.appColors.onBackground),
                    ),
            subtitle: Text(bazaar.message.toString(), style: theme.textTheme.h10
                // .copyWith(color: theme.appColors.onBackground),
                ),
            trailing: supporter
                ? Container(
                    child: Column(
                      children: [
                        // Text('Supporter request', style: theme.textTheme.h10),
                        IconButton(
                          icon: const Icon(Icons.person_add_alt),
                          onPressed: () async {
                            final result = await showConfirmDialog(context,
                                'Do you want to apply for supporters?');
                            if (result) {
                              viewModel.createSupporter(
                                bazaarId: bazaar.id.toString(),
                                uid: uid,
                                name: name,
                              );
                            }
                          },
                          tooltip: 'Supporter request',
                        ),
                      ],
                    ),
                  )
                : null,
            onTap: () {
              appRoute
                  .push(BazaarDetailsRoute(index: index, bazaarEvent: bazaar));
            },
          ),
        ],
      ),
    );
  }
}
