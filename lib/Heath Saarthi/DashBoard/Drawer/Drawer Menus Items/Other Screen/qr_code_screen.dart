import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Models/Drawer Menu/qr_code_model.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  GetAccessToken getAccessToken = GetAccessToken();
  QRCodeModel? qrCodeModel;
  bool isLoading = true;
  @override
  void initState() {
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = true;
        getQRCodeData().then((value) {
          setState(() {
            qrCodeModel = value;
            isLoading = false;
          });
        }).onError((error, stackTrace){
          setState(() {
            isLoading = false;
          });
        });
      });
    });

    super.initState();
  }

  Future<QRCodeModel?> getQRCodeData() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response =
          await http.get(Uri.parse(ApiUrls.qrCodeUrl), headers: headers);
      print("response ->${response.body}");
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == '402') {
        GetXSnackBarMsg.getWarningMsg('${jsonData['message']}');
        return QRCodeModel.fromJson(jsonData);
      } else {
        final jsonData = json.decode(response.body);
        return QRCodeModel.fromJson(jsonData);
      }
    } catch (e) {
      print("e->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrime,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "QR code",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: FontType.MontserratMedium,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white),
                child: isLoading == false
                    ? SingleChildScrollView(
                        child: qrCodeModel?.massage == '402'
                            ? TokenExpiredHelper()
                            : Column(
                                children: [
                                  const SizedBox(height: 15,),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    //height: MediaQuery.of(context).size.height / 1.1,
                                    color: qrCodeColor,
                                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Stack(
                                      alignment:  Alignment.topCenter,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width / 1.2,
                                            //height: MediaQuery.of(context).size.height / 1.3,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white,width: 2),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                            margin: const EdgeInsets.fromLTRB(15, 12, 15, 5),
                                            child: Column(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(height: 30),
                                                const Text('F  U  L  L   B  O  D  Y',style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black,fontWeight: FontWeight.bold)),
                                                const Divider(color: Colors.grey,thickness: 1,endIndent: 80,indent: 80),
                                                Text('CHECKUP AT HOME',style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 10),
                                                Text('${qrCodeModel?.data?.name ?? 'N/A'}',style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 3),
                                                Text('${qrCodeModel?.data?.mobile ?? 'N/A'}',style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 5),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                  child: Stack(
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                        child: Image(image: AssetImage('assets/Drawer/qrboxbg.png'),width: 300),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                                        child: qrCodeModel?.data?.qrcodeImagePath == null ? Container() :Container(
                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Image(image: NetworkImage('${qrCodeModel?.data?.qrcodeImagePath}'))
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Text('Book Full Body Checkup',style: TextStyle(fontFamily: FontType.MontserratRegular,fontWeight: FontWeight.bold),),
                                                const SizedBox(height: 2,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: hsPrime,
                                                  ),
                                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Accuris B+',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        WidgetSpan(
                                                          child: Transform.translate(
                                                            offset: const Offset(2, -8),
                                                            child: const Text(
                                                              've',
                                                              textScaleFactor: 0.8,
                                                              style: TextStyle(fontSize: 13,color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                const Text('With Health Sarthi',style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold)),
                                                Container(
                                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          bottomIconText(AppIcons().qrImgOne, 'Authorized', 'Collection Center'),
                                                          bottomIconText(AppIcons().qrImgTwo, 'Cash & Digital', 'Payment options'),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          bottomIconText(AppIcons().qrImgThree, 'Strict Safety and', 'Hygiene Measures'),
                                                          bottomIconText(AppIcons().qrImgFour, 'Reports via', 'Whatsapp & Email'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Text('All type Laboratory test \nfacility 24x7 (365 Day)',style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.center,)

                                              ],
                                            )
                                        ),
                                        Container(
                                          color: qrCodeColor,
                                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            child: const Image(image: AssetImage('assets/Drawer/applogo.png'),width: 130)
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var status = await Permission.storage.request();
                                          if (status.isGranted) {
                                            downloadFile(qrCodeModel?.pdf).catchError((onError) {
                                              debugPrint('Error downloading: $onError');
                                            }).then((imagePath) {
                                              debugPrint('Download successful, path: $imagePath');
                                              GetXSnackBarMsg.getSuccessMsg('Download path: $imagePath');
                                            });
                                          } else {
                                            downloadFile(qrCodeModel?.pdf).catchError((onError) {
                                              debugPrint('Error downloading: $onError');
                                            }).then((imagePath) {
                                              debugPrint('Download successful, path: $imagePath');
                                              GetXSnackBarMsg.getSuccessMsg('Download path: $imagePath');
                                            });
                                            //GetXSnackBarMsg.getWarningMsg('$status');
                                            print("status-$status");
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 2.5,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: hsPrime),
                                          child: const Text(
                                            'Download',
                                            style: TextStyle(
                                                fontFamily:
                                                    FontType.MontserratMedium,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final response = await get(
                                              Uri.parse(qrCodeModel!.pdf!));
                                          final directory =
                                              await getTemporaryDirectory();
                                          File file = await File(
                                                  '${directory.path}/HSQRCode.pdf')
                                              .writeAsBytes(response.bodyBytes);
                                          await Share.shareXFiles(
                                              [XFile(file.path)],
                                              text: 'Share');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 2.5,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: hsPrime),
                                          child: const Text(
                                            'Share',
                                            style: TextStyle(
                                                fontFamily:
                                                    FontType.MontserratMedium,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  showDownload == true
                                      ? Center(
                                          child: Text(
                                              'Downloading...${downloadProgress.toString().split('.').first} %'),
                                        )
                                      : Container()
                                ],
                              ))
                    : const CenterLoading(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomIconText(var imgIcon, var textOne, var textTwo){
    return Container(
      width: MediaQuery.of(context).size.width / 2.7,
      child: Row(
        children: [
          Image(image: imgIcon,width: 30),
          const SizedBox(width: 5),
          Text('$textOne\n$textTwo',style: const TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }


  //final imageSrc = 'https://picsum.photos/250?image=9';
  var downloadProgress = 0.0, imgCount = 0;
  bool showDownload = false;
  Future downloadFile(var imgUrl) async {
    setState(() {
      imgCount++;
      downloadProgress = 0.0;
      showDownload = true;
    });
    Dio dio = Dio();
    var imageDownloadPath = '/storage/emulated/0/Download/hsQRCode_$imgCount.pdf';
    await dio.download(imgUrl, imageDownloadPath,
        onReceiveProgress: (received, total) {
      var progress = (received / total) * 100;
      setState(() {
        downloadProgress = progress;
      });
      print("IMG Download Progress -> $downloadProgress");
    });
    setState(() {
      showDownload = false;
      downloadProgress = 0.0;
    });
    return imageDownloadPath;
  }
}
