//@dart=2.9
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Models/Drawer Menu/qr_code_model.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {

  GetAccessToken getAccessToken = GetAccessToken();
  QRCodeModel qrCodeModel;
  bool isLoading = true;
  @override
  void initState() {
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        isLoading = true;
        getQRCodeData().then((value){
          setState(() {
            qrCodeModel = value;
            isLoading = false;
          });
        });
      });
    });

    super.initState();
  }

  Future<QRCodeModel> getQRCodeData()async{
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try{
      final response = await http.get(
        Uri.parse(ApiUrls.qrCodeUrl),
        headers: headers
      );
      print("response ->${response.body}");
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == '402') {
        GetXSnackBarMsg.getWarningMsg('${jsonData['message']}');
        return QRCodeModel.fromJson(jsonData);
      } else {
        final jsonData = json.decode(response.body);
        return QRCodeModel.fromJson(jsonData);
      }
    }catch(e){
      print("e->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsOne,
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
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text("QR code",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: isLoading == false ? SingleChildScrollView(
                  child: qrCodeModel.status == '402' ? TokenExpiredHelper()
                      :Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: hsPrime,width: 1)
                            ),
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Image.network('${qrCodeModel.data.qrcodeImagePath}'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          downloadFile('${qrCodeModel.data.qrcodeImagePath}')
                           .catchError((onError) {
                           debugPrint('Error downloading: $onError');
                          })
                            .then((imagePath) {
                           debugPrint('Download successful, path: $imagePath');
                           GetXSnackBarMsg.getSuccessMsg('Download path: $imagePath');
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsOne),
                          child: Text('Download',style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                        ),
                      ),
                      SizedBox(height: 10),
                      showDownload == true ? Center(
                        child: Text('Downloading...${downloadProgress.toString().split('.').first} %'),
                      ) : Container()
                    ],
                  )
                ) : CenterLoading(),
              ),
            )
          ],
        ),
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
    var imageDownloadPath = '/storage/emulated/0/Download/hsQRCode_$imgCount.jpg';
    await dio.download(
        imgUrl,
        imageDownloadPath,
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
