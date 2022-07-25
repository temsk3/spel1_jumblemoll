import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jumblemoll/data/repository/bazaar/bazaar_repository_impal.dart';
import 'package:logger/logger.dart';

import '../hooks/use_l10n.dart';
import '../theme/app_theme.dart';
import 'bazaar_view_model.dart';

final logger = Logger();

final switchState = Provider.autoDispose((ref) {});

class SupporterPage extends HookConsumerWidget {
  const SupporterPage({Key? key, required this.bazaarId}) : super(key: key);
  final bazaarId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final viewModel = ref.watch(bazaarViewModelProvider.notifier);
    final asyncValue = ref.watch(supporterListStreamProvider(bazaarId));
    final active = useState<bool>(false);
    return asyncValue.when(
      data: (data) {
        return data != null
            ? Scaffold(
                // appBar: AppBar(
                //   automaticallyImplyLeading: false,
                //   actions: const [],
                // ),
                body: SafeArea(
                  child: Center(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        active.value = data[index].isActive as bool;

                        logger.d(active.value);

                        return SwitchListTile(
                          value: active.value,
                          title: Text(data[index].name.toString()),
                          onChanged: (value) async {
                            // active.value = value;
                            await viewModel.updateSupporter(
                                bazaarId: bazaarId,
                                uid: data[index].uid.toString(),
                                name: data[index].name.toString(),
                                isActive: active.value);
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
            : Container();
      },
      error: (e, msg) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(
              e.toString(),
              style: theme.textTheme.h30,
            ),
          ),
        ),
      ),
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
