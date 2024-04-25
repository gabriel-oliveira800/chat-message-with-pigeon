import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onClear;
  final VoidCallback? onRefresh;

  const CustomAppBar({
    super.key,
    this.onClear,
    this.onRefresh,
  });

  @override
  Size get preferredSize => const Size.fromHeight(78);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    final style = Theme.of(context).textTheme.titleLarge;

    return Container(
      color: Colors.purple,
      width: preferredSize.width,
      height: preferredSize.height,
      padding: padding.copyWith(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Messages',
            style: style?.copyWith(color: Colors.white),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(
              color: Colors.white,
              onRefresh != null ? Icons.refresh : Icons.delete,
            ),
            onPressed: onRefresh ?? onClear,
          ),
        ],
      ),
    );
  }
}
