import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<CustomerProvider>().customerList.isEmpty) {
        Provider.of<CustomerProvider>(context, listen: false).getCustomerList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: DeleteAppBar(
            didSelectAll: value.didSelectAll,
            cancelFunction: value.cancelFunction,
            deleteFunction: value.deleteFunction,
            selectAllFunction: value.selectAllFunction,
            selectedProductsToDelete: value.selectedCustomerToDelete,
            customAppBar: CustomAppBar(
              title: "MINI POS",
              actions: [
                GestureDetector(
                  onTap: () {
                    context.toNamed(fullPath: addCustomerScreen);
                  },
                  child: CircleAvatar(
                    backgroundColor: context.primaryColor,
                    radius: 20,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ).paddingHorizontal(10),
                ),
              ],
            ),
          ),
          body: const CustomerScreenWidget(),
        );
      },
    );
  }
}
