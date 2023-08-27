import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import '../Helpers/ColorBrightness.dart';
import '../IconPicker/iconPicker.dart';
import '../Models/IconPack.dart';

class FIPFullScreenDialog extends StatelessWidget {
  const FIPFullScreenDialog({
    Key? key,
    required this.iconController,
    required this.showSearchBar,
    required this.showTooltips,
    required this.backgroundColor,
    required this.title,
    required this.iconPackMode,
    required this.customIconPack,
    required this.searchIcon,
    required this.searchClearIcon,
    required this.searchHintText,
    required this.iconColor,
    required this.noResultsText,
    required this.iconSize,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.selectedIcon,
    required this.showSelectedIcon,
  }) : super(key: key);

  final FIPIconController iconController;
  final bool? showSearchBar;
  final bool? showTooltips;
  final Color? backgroundColor;
  final Widget? title;
  final List<IconPack>? iconPackMode;
  final Map<String, IconData>? customIconPack;
  final Icon? searchIcon;
  final Icon? searchClearIcon;
  final String? searchHintText;
  final Color? iconColor;
  final String? noResultsText;
  final double? iconSize;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final IconData? selectedIcon;
  final bool? showSelectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              if (selectedIcon != null)
                Container(
                    decoration: BoxDecoration(
                        color: iconColor != null && FIPColorBrightness(iconColor!).isLight() ? Colors.black : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15)),
                    height: kToolbarHeight,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      if (selectedIcon != null)
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child:
                                    SizedBox(height: 90, width: 90, child: Icon(selectedIcon, size: 90, color: iconColor ?? Colors.grey)))),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
                      ),
                    ])),
              if (selectedIcon == null)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(Icons.close, color: FIPColorBrightness(backgroundColor!).isLight() ? Colors.black : Colors.white),
                      onPressed: () => Navigator.pop(context)),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FIPIconPicker(
                    iconController: iconController,
                    showTooltips: showTooltips,
                    iconPack: iconPackMode,
                    customIconPack: customIconPack,
                    iconColor: iconColor,
                    backgroundColor: backgroundColor,
                    noResultsText: noResultsText,
                    iconSize: iconSize,
                    mainAxisSpacing: mainAxisSpacing,
                    crossAxisSpacing: crossAxisSpacing,
                    selectedIcon: selectedIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
