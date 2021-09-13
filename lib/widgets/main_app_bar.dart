import 'package:flutter/material.dart';
import 'package:mobile_wallet/constants/app_colors.dart';

// ignore: must_be_immutable
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({Key? key, required this.title, required this.height})
      : preferredSize = Size.fromHeight(height.value),
        super(key: key);

  /// title of the bar 
  ValueNotifier<String> title = ValueNotifier<String>('');

  /// height of the bar 
  ValueNotifier<double> height = ValueNotifier<double>(56);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children:  <Widget>[
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: widget.title,
              builder: (BuildContext context, String title, Widget? child) {
                return LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints boxConstraint) {
                      return SizedBox(
                        width: boxConstraint.maxWidth,
                        child: Text(
                          widget.title.value,
                          style: const TextStyle(color: AppColors.textWhite),
                        ),
                      );
                    },
                  );
            },),
          ),
        ],
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
        ),
        color: AppColors.textWhite,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: <Widget>[
        Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
      backgroundColor: AppColors.darkBlack,
    );
  }
}
