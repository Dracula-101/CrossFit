import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/api/bar_code_api.dart';
import 'package:crossfit/models/scanner_models/bar_code_model.dart';
import 'package:crossfit/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({super.key});

  @override
  State<BarCodeScanner> createState() => BarCodeScannerState();
}

class BarCodeScannerState extends State<BarCodeScanner> {
  String _scanBarcode = 'Unknown';
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  Future<dynamic>? barCodeModel;
  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    if (isUrl(_scanBarcode)) {
      if (await canLaunchUrlString(_scanBarcode)) {
        launchUrlString(_scanBarcode);
      }
    } else {
      barCodeModel = BarCodeAPI.getProduct(_scanBarcode) as Future<dynamic>?;
      setState(() {});
    }
  }

  SizedBox spacer({double height = 20}) => SizedBox(height: height);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        splashColor: lightGrey,
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          await scanBarcodeNormal();
        },
        onDoubleTap: () {},
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.black54,
                ),
                SizedBox(width: 20),
                Text(
                  'Scan Barcode',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).size.height * 0.1),
            children: [
              if (_scanBarcode == "Unknown" ||
                  _scanBarcode == "-1" ||
                  isUrl(_scanBarcode))
                Column(
                  children: [
                    slideAnimation(
                        position: 0,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Lottie.asset('assets/lottie/barcode.json'),
                      ),
                    ),
                    slideAnimation(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Scanning',
                            style: BoldText().boldVeryLargeText,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Barcode ',
                                  style: BoldText().boldVeryLargeText4.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: 'of different variations',
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      position: 1,
                    ),
                    spacer(height: 20),
                  ],
                ),
              _scanBarcode == "Unknown"
                  ? slideAnimation(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How to scan a barcode',
                            style: BoldText().boldLargeText,
                          ),
                          listTile('Open the bar code scanner'),
                          listTile('Point the camera to the bar code'),
                          listTile('Wait until the camera detects it'),
                          listTile('Get the details of the product'),
                        ],
                      ),
                      position: 2)
                  : slideAnimation(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_scanBarcode != "Unknown" ||
                              _scanBarcode != "-1" ||
                              !isUrl(_scanBarcode))
                            SizedBox(
                                height:
                                    MediaQuery.of(context).padding.top * 1.2),
                          Row(
                            children: [
                              if (_scanBarcode != "Unknown" ||
                                  _scanBarcode != "-1" ||
                                  !isUrl(_scanBarcode))
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.arrow_back_ios)),
                              Text(
                                'Barcode results',
                                style: BoldText().boldLargeText,
                              ),
                            ],
                          ),
                          _scanBarcode != "-1"
                              ? isUrl(_scanBarcode)
                                  ? Text(
                                      'Found a url: $_scanBarcode',
                                      style: NormalText().mediumText,
                                    )
                                  : Column(
                                      children: [
                                        FutureBuilder(
                                          future: barCodeModel,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if ((snapshot.data?.products
                                                          ?.isEmpty ??
                                                      false) ||
                                                  (snapshot.data?.products ==
                                                      null)) {
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Text(
                                                    'No product/s found',
                                                    style: BoldText()
                                                        .boldVeryLargeText,
                                                  ),
                                                );
                                              } else {
                                                return BarCodeDetails(
                                                    product: snapshot
                                                        .data!.products!.first);
                                              }
                                            } else {
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                        ),
                                      ],
                                    )
                              : Text(
                                  'Couldn\'t find anything. Try scanning the camera with a stable hand or try cleaning the lens of the camera',
                                  style: NormalText().mediumText,
                                ),
                        ],
                      ),
                      position: 3)
            ],
          );
        },
      ),
    );
  }

  Widget listTile(String text) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        minLeadingWidth: 2,
        horizontalTitleGap: 5,
        minVerticalPadding: 2,
        title: Text(text),
        leading: const Icon(Icons.details),
      );

  bool isUrl(String url) {
    return Uri.parse(url).isAbsolute;
  }
}

class BarCodeDetails extends StatelessWidget {
  final Products product;
  const BarCodeDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: black,
                      blurRadius: 7,
                      offset: const Offset(2, 2),
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: darkGreyContrast,
                      blurRadius: 7,
                      spreadRadius: 2,
                      offset: const Offset(-2, -2),
                    ),
                  ],
                  border: Border.all(
                    color: white.withOpacity(0.2),
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(product.images!.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (product.stores?.first.price != "")
              Positioned(
                left: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.width * 0.02,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.15,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      '₹${product.stores?.first.price}',
                      style: BoldText().boldNormalText,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Text(
          product.title ?? '',
          style: BoldText().boldVeryLargeText2,
        ),
        Text(product.brand ?? '', style: NormalText().mediumText),
        const SizedBox(
          height: 10,
        ),
        itemDetailsCol(
            item('Description', style: BoldText().boldLargeText),
            item(product.description ?? 'No description available',
                style: NormalText().mediumText),
            product.description),
        itemDetails(
            item('Height', style: BoldText().boldLargeText),
            item(product.height, style: NormalText().mediumText),
            product.height),
        itemDetails(
            item('Weight', style: BoldText().boldLargeText),
            item(product.weight, style: NormalText().mediumText),
            product.weight),
        itemDetailsCol(
            item('Ingredients', style: BoldText().boldLargeText),
            item(product.ingredients, style: NormalText().mediumText),
            product.ingredients),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itemDetailsCol(
              item("Available at", style: BoldText().boldLargeText),
              item(
                product.stores?.first.name ?? '',
              ),
              product.stores?.first.name,
            ),
            if (product.stores?.first != null &&
                product.stores?.first.link != null &&
                product.stores?.first.link != "")
              IconButton(
                  onPressed: () async {
                    if (await canLaunchUrlString(product.stores!.first.link!)) {
                      launchUrlString(product.stores!.first.link!);
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.rightFromBracket))
          ],
        )
      ],
    );
  }

  Widget listDetails(String left, String? right, dynamic value,
      {TextStyle leftStyle = const TextStyle(),
      TextStyle rightStyle = const TextStyle()}) {
    if (value != null || value != "") {
      return Row(
        children: [
          Text(
            left,
            style: BoldText().boldVeryLargeText.merge(leftStyle),
          ),
          Text(
            right ?? '',
            style: NormalText().normalText.merge(rightStyle),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget itemDetails(Widget left, Widget right, String? value,
      {TextStyle leftStyle = const TextStyle(),
      TextStyle rightStyle = const TextStyle()}) {
    if (value != "") {
      return Row(
        children: [
          left,
          const SizedBox(
            width: 10,
          ),
          right,
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget itemDetailsCol(Widget left, Widget right, String? value,
      {TextStyle leftStyle = const TextStyle(),
      TextStyle rightStyle = const TextStyle()}) {
    if (value != "") {
      return Column(
        children: [
          left,
          right,
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget item(dynamic item, {TextStyle style = const TextStyle()}) {
    if (item != null || item != "") {
      return Text(
        item,
        style: NormalText().normalText.merge(style),
      );
    }
    return const SizedBox();
  }
}
