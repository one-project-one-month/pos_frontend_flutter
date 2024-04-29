import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/customers/customers.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({
    super.key,
    required this.customerList,
    this.selectedCustomersToDelete = const [],
    this.trailingOnTap,
    this.trailindWidget,
    this.isFileredList = false,
    this.selectFunction,
    this.goToEditScreen,
  });

  final void Function(CustomerModel model)? trailingOnTap;
  final Widget? trailindWidget;
  final bool isFileredList;
  final List<CustomerModel> customerList;
  final List<CustomerModel> selectedCustomersToDelete;
  final void Function(CustomerModel model)? selectFunction;
  final void Function(CustomerModel model)? goToEditScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isFileredList)
          Row(
            children: [
              Text.rich(
                TextSpan(children: [
                  const TextSpan(text: "Customers Found: "),
                  TextSpan(text: customerList.length.toString())
                ]),
                style: context.textTheme.titleSmall?.copyWith(
                  color: Colors.black,
                ),
              )
            ],
          ).paddingVertical(10),
        ListView.separated(
          shrinkWrap: true,
          itemCount: customerList.length,
          separatorBuilder: (context, index) {
            return 20.height;
          },
          itemBuilder: (context, index) {
            final customer = customerList[index];
            return GestureDetector(
              onTap: selectedCustomersToDelete.isNotEmpty
                  ? () {
                      selectFunction?.call(customer);
                    }
                  : () {
                      goToEditScreen?.call(customer);
                    },
              onLongPress: () {
                selectFunction?.call(customer);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "State Code",
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                customer.stateCode,
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${customer.customerName} (${customer.customerCode})",
                                style: context.textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              5.height,
                              Text(
                                customer.dateOfBirth,
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              5.height,
                              Text(
                                customer.gender,
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Mobile NO.",
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                customer.mobileNo,
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  UnconstrainedBox(
                    child: selectedCustomersToDelete.isNotEmpty
                        ? Checkbox(
                            value: selectedCustomersToDelete.contains(customer),
                            onChanged: (val) {
                              selectFunction?.call(customer);
                            },
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
