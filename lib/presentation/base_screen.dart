import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Drawer? drawer;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? backgroundColor;
  final String? restorationId;
  final double? appBarElevation;
  final Color? appBarBackgroundColor;
  final Brightness? appBarBrightness;
  final IconThemeData? appBarIconTheme;
  final TextTheme? appBarTextTheme;
  final double? appBarTitleSpacing;
  final bool? appBarAutomaticallyImplyLeading;
  final bool endDrawerEnableOpenDragGesture;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final IconThemeData? drawerIconTheme;
  final TextTheme? drawerTextTheme;
  final DragStartBehavior drawerDragStartBehavior;
  final bool? drawerDragStartBehaviorExplicit;
  final double? endDrawerElevation;
  final Color? endDrawerBackgroundColor;
  final Brightness? endDrawerOpenThreshold;
  final Color? endDrawerCloseThreshold;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final Widget? endDrawer;
  final void Function(bool)? onDrawerChanged;
  final AlignmentDirectional persistentFooterAlignment;
  final String? topGradient;
  final String? bottomGradient;
  final bool wrapWithSafeArea;
  final bool wrapWithAnnotatedRegion;
  final SystemUiOverlayStyle value;
  final bool showGradients;

  const BaseScreen({
    super.key,
    this.appBar,
    this.drawer,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor,
    this.restorationId,
    this.appBarElevation,
    this.appBarBackgroundColor,
    this.appBarBrightness,
    this.appBarIconTheme,
    this.appBarTextTheme,
    this.appBarTitleSpacing,
    this.appBarAutomaticallyImplyLeading,
    this.endDrawerEnableOpenDragGesture = true,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.drawerIconTheme,
    this.drawerTextTheme,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerDragStartBehaviorExplicit,
    this.endDrawerElevation,
    this.endDrawerBackgroundColor,
    this.endDrawerOpenThreshold,
    this.endDrawerCloseThreshold,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawer,
    this.onDrawerChanged,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.topGradient,
    this.bottomGradient,
    this.wrapWithSafeArea = true,
    this.wrapWithAnnotatedRegion = true,
    this.value = SystemUiOverlayStyle.light,
    this.showGradients = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      key: key,
      drawer: drawer,
      body: Container(
        width: context.width,
        height: context.height,
        decoration: showGradients
            ? BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: ExactAssetImage(
                    bottomGradient ??
                        'assets/images/main_img_bottombar_gradient.jpeg',
                  ),
                ),
              )
            : null,
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor,
      restorationId: restorationId,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      onEndDrawerChanged: onEndDrawerChanged,
      drawerScrimColor: drawerScrimColor,
      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawer: endDrawer,
      onDrawerChanged: onDrawerChanged,
      persistentFooterAlignment: persistentFooterAlignment,
    ).wrapWithAnnotatedRegion(
      value: value,
      wrap: wrapWithAnnotatedRegion,
    );
  }
}

extension WidgetX on Widget {
  Widget wrapWithAnnotatedRegion({
    required SystemUiOverlayStyle value,
    bool wrap = false,
  }) {
    if (!wrap) return this;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value,
      child: this,
    );
  }
}
