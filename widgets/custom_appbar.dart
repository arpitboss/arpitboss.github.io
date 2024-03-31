import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon1,
    required this.trailingIcon2,
    required this.preferredHeight,
  });

  final IconData leadingIcon;
  final IconData trailingIcon1;
  final IconData trailingIcon2;
  final double preferredHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xf4f6fbff),
      leading: IconButton(
        icon: Icon(leadingIcon),
        onPressed: () {},
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: Icon(trailingIcon1),
              onPressed: () {},
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              icon: Icon(trailingIcon2),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
