import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/context_extensions.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_page.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_bar.dart';

class MushafListViewBuilder extends ConsumerStatefulWidget {
  const MushafListViewBuilder({super.key});

  @override
  ConsumerState<MushafListViewBuilder> createState() =>
      _MushafListViewBuilderState();
}

class _MushafListViewBuilderState extends ConsumerState<MushafListViewBuilder> {
  OverlayEntry? overlay;

  late final textEditingController = TextEditingController();

  late final scrollController = ref.read(mushafScrollCtrlProvider);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final screenSize = MediaQuery.of(context).size;

    final itemExtent = isPortrait ? screenSize.height : screenSize.width * 2;

    return ListView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemExtent: itemExtent,
      itemCount: 480,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            overlay = context.insertOverlay(
              onTapOutside: () {
                context.removeOverlayEntry(overlay);
              },
              children: [
                NavRailBar(
                  removeOverlay: () {
                    context.removeOverlayEntry(overlay);
                  },
                ),
              ],
            );
          },
          onLongPress: () {},
          child: MushafPage(index: index),
        );
      },
    );
  }
}
