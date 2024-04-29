import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../products/products.dart';
import '../../ui/ui.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    super.key,
    required this.selectedProductList,
    required this.totalPrice,
    required this.totalQty,
  });
  final List<ProductModel> selectedProductList;
  final double totalPrice;
  final int totalQty;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final screenshotController = ScreenshotController();
  String? qrImagePath;
  bool onGenrateQr = false;

  double calculateTaxAmount(double totalPrice, double tax) {
    return (totalPrice * tax) / 100;
  }

  double calculateDiscountAmount(double totalPrice, double discount) {
    return (totalPrice * discount) / 100;
  }

  double calculateFinalPrice(double totalPrice, double tax, double discount) {
    double taxAmount = calculateTaxAmount(totalPrice, tax);
    double discountAmount = calculateDiscountAmount(totalPrice, discount);
    return totalPrice + taxAmount - discountAmount;
  }

  double calculateChange(double totalPrice, double receiveAmount) {
    return receiveAmount - totalPrice;
  }

  Future<void> captureScreenShot() async {
    // final fileName =
    //     "transcation-${DateTime.now().toUtc().toString().split(".").first}.png";
    Directory directory;

    if (Platform.isIOS) {
      // final downloadDir = await getDownloadsDirectory();
      // if (downloadDir != null) {
      //   directory = Directory(downloadDir.path);
      // } else {

      final appDir = await getApplicationDocumentsDirectory();
      final checkParentPath = "${appDir.path}/MiniPOS";
      final checkDirectory = Directory(checkParentPath).existsSync();
      if (!checkDirectory) {
        directory = await Directory(checkParentPath).create(recursive: true);
      } else {
        directory = Directory(checkParentPath);
      }

      // }
    } else {
      // For Android
      // Request permissions first
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final path = await getExternalStorageDirectory();
        final androidPath = path!.path.split("Android");
        final checkParentPath = "${androidPath[0]}Download/MiniPOS";
        final checkDirectory = Directory(checkParentPath).existsSync();

        if (!checkDirectory) {
          directory = await Directory(checkParentPath).create(recursive: true);
        } else {
          directory = Directory(checkParentPath);
        }
      } else {
        // Handle denied permission
        debugPrint("Permission denied");
        return;
      }
    }

    debugPrint(
        "--------------------- path ${directory.path} ------------------");
    final val = await screenshotController.captureAndSave(directory.path);

    setState(() {
      onGenrateQr = true;
    });

    if (val != null && val.isNotEmpty) {
      if (Platform.isAndroid) {
        await MediaScanner.loadMedia(
          path: val,
        );
      }
      debugPrint("--------------------- val $val ------------------");
      final imageFile = File(val);
      await storeToFirebase(imageFile);
      context.read<ProductProvider>().clearSelectedProductList();
    }
  }

  Future<void> storeToFirebase(File imageFile) async {
    final path = "qr_images/${imageFile.path.split("/").last}";

    debugPrint("--------------------- path s $path ------------------");

    final ref = FirebaseStorage.instance.ref().child(path);

    final uploadTask = ref.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() {});

    debugPrint("--------------------- $snapshot ------------------");

    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      qrImagePath = downloadUrl;
      onGenrateQr = false;
    });

    debugPrint(
      "--------------------- download $downloadUrl ------------------",
    );
  }

  @override
  Widget build(BuildContext context) {
    String paymentType = "CASH";
    double tax = 5;
    double discount = 10;
    String staffCode = "001";
    double receiveAmount = widget.totalPrice + 2000;
    double? change;
    String customerCode = "001";
    double finalPrice = calculateFinalPrice(widget.totalPrice, tax, discount);
    double taxAmount = calculateTaxAmount(widget.totalPrice, tax);
    double discountAmount =
        calculateDiscountAmount(widget.totalPrice, discount);
    change = calculateChange(finalPrice, receiveAmount);
    final selectedCustomer = context.watch<CustomerProvider>().selectedCustomer;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Invoice",
      ),
      bottomNavigationBar: onGenrateQr || qrImagePath != null
          ? null
          : Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: captureScreenShot,
                child: const Text("Save and Print QR"),
              ),
            ),
      body: onGenrateQr
          ? Column(
              children: [
                LottieBuilder.asset(loading),
                Text(
                  "Generating QR",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
              ],
            )
          : qrImagePath != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Saved Invoice Successfully",
                      style: context.textTheme.displaySmall
                          ?.copyWith(color: Colors.black),
                    ),
                    if (qrImagePath != null)
                      QrImageView(
                        data: qrImagePath!,
                      ).paddingAll(20),
                    Text(
                      "Thanks for purchasing from Flutter Shop",
                      style: context.textTheme.displaySmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ListTile(
                                trailing: Text("Voucher No. #24230"),
                              ),
                              10.height,
                              ProductList(
                                productList: widget.selectedProductList,
                              ),
                              10.height,
                              CusRow(
                                title: Text(
                                  "Purchased Time",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  DateTime.now()
                                      .toUtc()
                                      .toString()
                                      .split(".")
                                      .first,
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Payment Type",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  paymentType.toString(),
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Staff Code",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  staffCode,
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              if (selectedCustomer != null)
                                CusRow(
                                  title: Text(
                                    "Customer Code",
                                    style: context.textTheme.labelMedium,
                                  ),
                                  trailing: Text(
                                    selectedCustomer.customerCode,
                                    style: context.textTheme.labelLarge,
                                  ),
                                ),
                              const Divider(),
                              CusRow(
                                title: Text(
                                  "Total Quantity",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  "${widget.totalQty}",
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Total Price",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  "${widget.totalPrice.toStringAsFixed(2)} MMK",
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Tax",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  "${taxAmount.toStringAsFixed(2)} MMK ($tax %) ",
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Discount",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  "${discountAmount.toStringAsFixed(2)} MMK ($discount %)",
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Sub Total",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  "${finalPrice.toStringAsFixed(2)} MMK",
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              CusRow(
                                title: Text(
                                  "Change",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Text(
                                  "${change.toStringAsFixed(2)} MMK",
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              20.height,
                              Text(
                                "❤️ Thanks for purchasing from Flutter Shop ❤️",
                                style: context.textTheme.labelLarge,
                              ),
                              20.height,
                            ],
                          ),
                        ),
                      ],
                    ).paddingAll(20),
                  ),
                ),
    );
  }
}

class CusRow extends StatelessWidget {
  const CusRow({super.key, required this.title, required this.trailing});
  final Widget title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [title, trailing],
    ).paddingHorizontal(30).paddingVertical(10);
  }
}
