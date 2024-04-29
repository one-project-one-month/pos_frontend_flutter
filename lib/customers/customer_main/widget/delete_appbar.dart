import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/customers/customers.dart';

class DeleteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DeleteAppBar({
    super.key,
    required this.cancelFunction,
    required this.deleteFunction,
    required this.selectAllFunction,
    required this.selectedProductsToDelete,
    required this.customAppBar,
    this.didSelectAll = false,
  });

  final VoidCallback cancelFunction;
  final VoidCallback deleteFunction;
  final VoidCallback selectAllFunction;

  final List<CustomerModel> selectedProductsToDelete;
  final PreferredSizeWidget customAppBar;
  final bool didSelectAll;

  @override
  Widget build(BuildContext context) {
    if (selectedProductsToDelete.isNotEmpty) {
      return SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: cancelFunction,
              child: Text(
                "Cancel",
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.secondaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: deleteFunction,
              child: Text(
                "Delete",
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.secondaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: didSelectAll ? cancelFunction : selectAllFunction,
              child: Text(
                didSelectAll ? "Unselect All" : "Select All",
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.secondaryColor,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return customAppBar;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
