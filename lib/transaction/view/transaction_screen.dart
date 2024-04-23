import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Transaction",
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
                      "Saved Transaction Successfully",
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
                          padding: const EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            children: [
                              ProductList(
                                selectedProductList: widget.selectedProductList,
                              ).paddingHorizontal(20),
                              10.height,
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
                              20.height,
                              Text(
                                "❤️ Thanks for purchasing from Flutter Shop ❤️",
                                style: context.textTheme.labelLarge,
                              ),
                              20.height,
                            ],
                          ),
                        ),
                        const Positioned(
                          top: -40,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: CachedNetworkImageProvider(
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
