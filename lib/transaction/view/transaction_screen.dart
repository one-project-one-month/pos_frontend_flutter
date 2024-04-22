import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String? captureImagePath;

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

    if (val != null && val.isNotEmpty) {
      if (Platform.isAndroid) {
        await MediaScanner.loadMedia(
          path: val,
        );
      }
    }

    debugPrint("--------------------- val $val ------------------");

    setState(() {
      captureImagePath = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Transaction",
      ),
      bottomNavigationBar: captureImagePath == null
          ? ElevatedButton(
              onPressed: captureScreenShot,
              child: const Text("Save"),
            )
          : null,
      body: captureImagePath != null
          ? Center(
              child: Column(
                children: [
                  Text(
                    "Saved Image Successfully",
                    style: context.textTheme.displaySmall
                        ?.copyWith(color: Colors.black),
                  ),
                  Expanded(
                    child: Image.file(
                      File(captureImagePath!),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Screenshot(
                controller: screenshotController,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          SelectedProductList(
                            isFromTransaction: true,
                            selectedProductList: widget.selectedProductList,
                          ),
                          ListTile(
                            title: const Text("Transaction Time"),
                            trailing: Text(
                              DateTime.now()
                                  .toUtc()
                                  .toString()
                                  .split(".")
                                  .first,
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          ListTile(
                            title: const Text("Total Quantity"),
                            trailing: Text(
                              "${widget.totalQty}",
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          ListTile(
                            title: const Text("Total Price"),
                            trailing: Text(
                              "${widget.totalPrice} MMK",
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: -50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://w7.pngwing.com/pngs/537/866/png-transparent-flutter-hd-logo.png",
                        ),
                      ),
                    ),
                  ],
                ).paddingHorizontal(20).paddingVertical(70),
              ),
            ),
    );
  }
}
