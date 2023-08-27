/// IconPicker
/// Author Rebar Ahmad
/// https://github.com/Ahmadre
/// rebar.ahmad@gmail.com

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:provider/provider.dart';
import 'icons.dart';
import '../Models/IconPack.dart';
import '../Helpers/ColorBrightness.dart';

class FIPIconPicker extends StatefulWidget {
  final FIPIconController iconController;
  final List<IconPack>? iconPack;
  final Map<String, IconData>? customIconPack;
  final double? iconSize;
  final Color? iconColor;
  final String? noResultsText;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final Color? backgroundColor;
  final bool? showTooltips;
  final IconData? selectedIcon;

  const FIPIconPicker({
    Key? key,
    required this.iconController,
    required this.iconPack,
    required this.iconSize,
    required this.noResultsText,
    required this.backgroundColor,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.iconColor,
    this.showTooltips,
    this.customIconPack,
    this.selectedIcon,
  }) : super(key: key);

  @override
  _FIPIconPickerState createState() => _FIPIconPickerState();
}

class _FIPIconPickerState extends State<FIPIconPicker> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.customIconPack != null) {
        if (mounted) widget.iconController.addAll(widget.customIconPack ?? {});
      }

      if (widget.iconPack != null)
        for (var pack in widget.iconPack!) {
          if (mounted) widget.iconController.addAll(FIPIconManager.getSelectedPack(pack));
        }
    });
  }

  Widget _getListEmptyMsg() => Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: RichText(
            text: TextSpan(
              text: widget.noResultsText! + ' ',
              style: TextStyle(
                color: FIPColorBrightness(widget.backgroundColor!).isLight() ? Colors.black : Colors.white,
              ),
              children: [
                TextSpan(
                  text: widget.iconController.searchTextController.text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: FIPColorBrightness(widget.backgroundColor!).isLight() ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<FIPIconController>(
      builder: (ctx, controller, _) => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Stack(
          children: <Widget>[
            if (controller.icons.length == 0)
              _getListEmptyMsg()
            else
              Positioned.fill(
                child: GridView.builder(
                    controller: ScrollController(
                        initialScrollOffset:
                            ((controller.icons.entries.toList().indexWhere((x) => x.value == widget.selectedIcon) + 1) / 7).floor() * 50),
                    itemCount: controller.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: widget.mainAxisSpacing ?? 5,
                      crossAxisSpacing: widget.crossAxisSpacing ?? 5,
                      maxCrossAxisExtent: widget.iconSize != null ? widget.iconSize! + widget.iconSize! * 0.25 : 50,
                    ),
                    itemBuilder: (context, index) {
                      var item = controller.entries.elementAt(index);
                      var icon = Center(child: Icon(item.value, size: widget.iconSize, color: widget.iconColor));
                      var iconWidget = widget.selectedIcon == item.value
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(widget.iconSize! * 0.25),
                                border:
                                    Border.all(color: widget.iconColor ?? Theme.of(context).primaryColor, width: widget.iconSize! * 0.05),
                              ),
                              child: icon,
                            )
                          : icon;

                      return GestureDetector(
                        onTap: () => Navigator.pop(context, item.value),
                        child: widget.showTooltips!
                            ? Tooltip(
                                message: item.key,
                                child: iconWidget,
                              )
                            : iconWidget,
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
