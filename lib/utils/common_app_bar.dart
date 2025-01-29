import 'package:flutter/material.dart';
import 'package:sendmoney_interview/utils/bottom_sheet_dialog.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout;
  final bool showBackButton;
  final IconData backIcon;


  const CommonAppBar({
    super.key,
    required this.title,
    this.showLogout = true,
    this.showBackButton = true,
    this.backIcon = Icons.arrow_back, // Default back icon
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: Icon(backIcon, color: Colors.white, size: 28), // Custom back icon
        onPressed: () => Navigator.pop(context),
      )
          : const Icon(Icons.menu_rounded, color: Colors.white),
      actions: showLogout
          ? [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showLogoutBottomSheet(context);
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
