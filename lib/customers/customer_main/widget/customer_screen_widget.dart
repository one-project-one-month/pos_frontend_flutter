import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:provider/provider.dart';

import '../../../_application/application.dart';

class CustomerScreenWidget extends StatelessWidget {
  const CustomerScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, value, child) {
        if (value.getProductListStatus == ApiStatus.loading) {
          return Center(
            child: LottieBuilder.asset(loading),
          );
        } else {
          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            displacement: 100,
            onRefresh: () async {
              value.getCustomerList();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: value.customerList.isEmpty
                  ? Column(
                      children: [
                        LottieBuilder.asset(notFound),
                        Text(
                          "No Customers",
                          style: context.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        TextFormField(
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                          ),
                          controller: value.searchController,
                          focusNode: value.searchFocus,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: value.searchProduct,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            labelText: "Search Customer",
                          ),
                        ),
                        20.height,
                        if (!value.isFound)
                          Column(
                            children: [
                              LottieBuilder.asset(notFound),
                              Text(
                                "No searched customers are found.",
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          )
                        else
                          CustomerList(
                            goToEditScreen: (product) =>
                                value.gotoEditScreen(context, product),
                            selectFunction: value.selectFunction,
                            isFileredList:
                                value.searchedCustomerList.isNotEmpty,
                            selectedCustomersToDelete:
                                value.selectedCustomerToDelete,
                            customerList: value.searchedCustomerList.isEmpty
                                ? value.customerList
                                : value.searchedCustomerList,
                          ),
                      ],
                    ).paddingHorizontal(20).paddingVertical(10),
            ),
          );
        }
      },
    );
  }
}
