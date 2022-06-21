import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../hooks/use_l10n.dart';
import '../../hooks/use_router.dart';
import '../../theme/app_theme.dart';

class PictureCover extends HookConsumerWidget {
  const PictureCover({Key? key, required this.picture}) : super(key: key);
  final String? picture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    return Container(
      // color: theme.appColors.primary,
      child: Center(
        child: (picture == null || picture == '')
            ? Text('NoImage', style: theme.textTheme.h30
                // .copyWith(color: theme.appColors.onPrimary),
                )
            : SizedBox.expand(
                child: Image.network(picture.toString()),
              ),
      ),
    );
  }
}

class PictureDetail extends HookConsumerWidget {
  const PictureDetail({Key? key, required this.picture, this.oldPicture})
      : super(key: key);
  final Uint8List? picture;
  final String? oldPicture;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    return Container(
      height: 100,
      width: 160,
      color: Colors.grey.withOpacity(0.3),
      alignment: Alignment.center,
      child: (picture == null)
          ? (oldPicture == '' || oldPicture == null)
              ? const Icon(Icons.add_photo_alternate)
              : SizedBox.expand(child: Image.network(oldPicture as String))
          : SizedBox.expand(
              child: Image.memory(picture as Uint8List),
            ),
    );
  }
}
