import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../data/model/bazaar/bazaar_model.dart';
import '../common/image_crop_controller.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';
import 'bazaar_view_model.dart';

class BazaarAddPage extends HookConsumerWidget {
  const BazaarAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final mode = ref.watch(appThemeModeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    // final state = ref.watch(bazzarViewModelProvider);
    final viewModel = ref.watch(bazzarViewModelProvider.notifier);
    final bazaar = Bazaar.empty();
    //
    final form = GlobalKey<FormState>();
    DateTime now = DateTime.now();
    String uid = 'test';

    final name = useTextEditingController(text: bazaar.name);
    final message = useTextEditingController(text: bazaar.message);
    final salesStart = useTextEditingController(
        text: dateFormat.format(
            bazaar.salesStart != null ? bazaar.salesStart as DateTime : now));
    final salesEnd = useTextEditingController(
        text: dateFormat.format(
            bazaar.salesEnd != null ? bazaar.salesEnd as DateTime : now));
    final eventFrom = useTextEditingController(
        text: dateFormat.format(
            bazaar.eventFrom != null ? bazaar.eventFrom as DateTime : now));
    final eventTo = useTextEditingController(
        text: dateFormat
            .format(bazaar.eventTo != null ? bazaar.eventTo as DateTime : now));
    final place = useTextEditingController(text: bazaar.place);
    //
    final ImagePicker picker = ImagePicker();

    // return state.when(
    //   data: (data) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: theme.appColors.primary,
        //foregroundColor: theme.appColors.onPrimary,
        // toolbarHeight: 30,
        title: Text(
          'Event',
          style: theme.textTheme.h40,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: const AutoLeadingButton(),
        actions: [
          IconButton(
            onPressed: () async {
              if (form.currentState!.validate()) {
                form.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                viewModel.addBazaarEvent(
                  organizer: uid,
                  name: name.text,
                  message: message.text,
                  salesStart: DateTime.parse(salesStart.text),
                  salesEnd: DateTime.parse(salesEnd.text),
                  eventFrom: DateTime.parse(eventFrom.text),
                  eventTo: DateTime.parse(eventTo.text),
                  place: place.text,
                  picture: (ref.watch(
                              imageCropProvider.select((s) => s.croppedData)) ==
                          null)
                      ? null
                      : (ref.watch(
                              imageCropProvider.select((s) => s.croppedData))
                          as Uint8List),
                );
                appRoute.pop();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          // child: BazaarForm(bazaar: Bazaar.empty()
          child: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    form.currentState!.save();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    await ref.read(imageCropProvider.notifier).pickImage(image);
                    await appRoute.push(const ImageCropRoute());
                  },
                  child: Container(
                    height: 100,
                    width: 300,
                    // color: theme.appColors.primary,
                    color: Colors.grey.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: ref.watch(imageCropProvider
                                .select((s) => s.croppedData)) ==
                            null
                        ? const Icon(
                            Icons.add_photo_alternate,
                            // color: theme.appColors.onPrimary,
                          )
                        : SizedBox.expand(
                            child: Image.memory(
                            ref.watch(imageCropProvider
                                .select((s) => s.croppedData)) as Uint8List,
                          )),
                  ),
                ),
                TextFormField(
                  controller: name,
                  // style: TextStyle(color: theme.appColors.onPrimary),
                  decoration: const InputDecoration(labelText: 'title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name.text = value.toString();
                  },
                  // onChanged: (value) {
                  // _name.text = value.toString();
                  // },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                //
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // primary: theme.appColors.primary,
                          // onPrimary: theme.appColors.onPrimary,
                          ),
                      child: const Text('販売期間'),
                      onPressed: () async {
                        final dateRange = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                              start: DateTime.now(), end: DateTime.now()),
                          firstDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year + 3),
                          builder: isDarkMode(context)
                              ? null
                              : (context, child) {
                                  return Theme(
                                    data: theme.data.copyWith(
                                      colorScheme:
                                          theme.data.colorScheme.copyWith(
                                        surface: theme.appColors.primary,
                                      ),
                                    ),
                                    child: child as Widget,
                                  );
                                },
                        );
                        if (dateRange != null) {
                          salesStart.text = dateFormat.format(dateRange.start);
                          salesEnd.text = dateFormat.format(dateRange.end);
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: salesStart,
                        // style: TextStyle(color: theme.appColors.onPrimary),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "From",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (DateTime.parse(value)
                              .isAfter(DateTime.parse(eventFrom.text))) {
                            return 'Please enter a date after the specified date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          salesStart.text = value.toString();
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: salesEnd,
                        // style: TextStyle(color: theme.appColors.onPrimary),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "To",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          salesEnd.text = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // primary: theme.appColors.primary,
                          // onPrimary: theme.appColors.onPrimary,
                          ),
                      child: const Text('開催期間'),
                      onPressed: () async {
                        final dateRange = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                            start: DateTime.parse(salesStart.text),
                            end: DateTime.parse(salesEnd.text),
                          ),
                          firstDate: DateTime(now.year, now.month, now.day),
                          lastDate: DateTime(now.year + 3),
                          builder: isDarkMode(context)
                              ? null
                              : (context, child) {
                                  return Theme(
                                    data: theme.data.copyWith(
                                      colorScheme:
                                          theme.data.colorScheme.copyWith(
                                        surface: theme.appColors.primary,
                                      ),
                                    ),
                                    child: child as Widget,
                                  );
                                },
                          //     (context, child) {
                          //   return Theme(
                          //     data: Theme.of(context).copyWith(
                          //       colorScheme:
                          //           Theme.of(context).colorScheme.copyWith(
                          //                 surface: Theme.of(context)
                          //                     .colorScheme
                          //                     .tertiary,
                          //                 onPrimary: Theme.of(context)
                          //                     .colorScheme
                          //                     .onPrimary,
                          //               ),
                          //       backgroundColor: Theme.of(context)
                          //           .colorScheme
                          //           .surfaceVariant,
                          //       dialogBackgroundColor: Theme.of(context)
                          //           .colorScheme
                          //           .surfaceVariant,
                          //       scaffoldBackgroundColor: Theme.of(context)
                          //           .colorScheme
                          //           .surfaceVariant,
                          //     ),
                          //     child: child as Widget,
                          //   );
                          // },
                        );
                        if (dateRange != null) {
                          eventFrom.text =
                              dateFormat.format(dateRange.start).toString();
                          eventTo.text =
                              dateFormat.format(dateRange.end).toString();
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: eventFrom,
                        // style: TextStyle(color: theme.appColors.onPrimary),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "From",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          eventFrom.text = value.toString();
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: eventTo,
                        // style: TextStyle(color: theme.appColors.onPrimary),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "To",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (DateTime.parse(salesEnd.text)
                              .isAfter(DateTime.parse(value))) {
                            return 'Please enter a date after the specified date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          eventTo.text = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                TextFormField(
                  controller: place,
                  // style: TextStyle(color: theme.appColors.onPrimary),
                  decoration: const InputDecoration(labelText: 'place'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    place.text = value.toString();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                TextFormField(
                  controller: message,
                  maxLines: 2,
                  // style: TextStyle(color: theme.appColors.onPrimary),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'message',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    message.text = value.toString();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // },
    // error: (e, msg) => Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: Text(
    //         e.toString(),
    //         style: theme.textTheme.h30,
    //       ),
    //     ),
    //   ),
    // ),
    // loading: () {
    //   return Scaffold(
    //     body: SafeArea(
    //       child: Center(
    //         child: CircularProgressIndicator(
    //           color: theme.appColors.primary,
    //         ),
    //       ),
    //     ),
    //   );
    // },
    // );
  }
}

///true:dark, false:light
bool isDarkMode(BuildContext context) {
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  return brightness == Brightness.dark;
}
