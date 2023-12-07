
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Profile%20Menu/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.28,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ProfileWidgets(),
        /*child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                controller: firstNm,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'First name',
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: Icon(Icons.person, color: hsBlack,size: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                controller: mobile,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Mobile no',
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: Icon(Icons.mobile_friendly, color: hsBlack,size: 20),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                controller: email,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Email id',
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: Icon(Icons.email, color: hsBlack,size: 20),
                ),
              ),
            ),

            showTextField('Address', address,Icons.location_city),
            showTextField('State', state,Icons.query_stats),
            showTextField('City', city,Icons.reduce_capacity),
            showTextField('Area', area,Icons.area_chart),
            showTextField('Branch', branch,Icons.location_city),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: '${(pincode == null || pincode == '') ? 'N/A' : '$pincode'}',
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: Icon(Icons.code_rounded, color: hsBlack,size: 20),
                ),
              ),
            ),
            //showTextField('PinCode', pincode,Icons.code),
            showTextField('Bank name', bankNm,Icons.account_balance_rounded),
            showTextField('IFSC code', ifscCode,Icons.account_tree_rounded),
            showTextField('Account number', accountNo,Icons.account_balance_wallet_rounded),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: '${(gstNo == 'null' || gstNo == '') ? 'N/A' : '$gstNo'}',
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: Icon(Icons.app_registration_rounded, color: hsBlack,size: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen(accessToken: getAccessToken.access_token)));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: const ListTile(
                    title: Text("Change password",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      title: const Text("Pan Card",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                      subtitle: Text(panCardChange == null ? '$panCard' : 'Pan Card is picked',
                        style: TextStyle(
                            fontFamily: FontType.MontserratRegular,
                            color: panCardChange == null ? Colors.black87 : hsPrime,
                            fontSize: 10),
                      ),
                      trailing: Container(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                            userStatus == '0' ? TextButton(
                                onPressed: ()async{
                                  var panCardCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    panCardChange = panCardCamera;
                                  });
                                },
                                child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                            ) : Container()
                          ],
                        ),
                      ),
                      children: [
                        panCardImg == 'null' ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Image not found"),
                        ) : Image.network(
                          '$panCardImg',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      title: const Text("Aadhaar card front",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                      subtitle: Text(aadhaarCardFChange == null
                          ? '$aadharCardF' : 'Aadhaar card front is picked',
                        style: TextStyle(
                            fontFamily: FontType.MontserratRegular,
                            color: aadhaarCardFChange == null  ? Colors.black87 : hsPrime,
                            fontSize: 10),
                      ),
                      trailing: Container(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                            userStatus == '0' ? TextButton(
                                onPressed: ()async{
                                  var aadhaarCardFrontCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    aadhaarCardFChange = aadhaarCardFrontCamera;
                                  });
                                },
                                child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                            ) : Container()
                          ],
                        ),
                      ),
                      children: [
                        aadharCardFImg == 'null' ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Image not found"),
                        ) :Image.network(
                          '$aadharCardFImg',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      title: const Text("Aadhaar card back",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                      subtitle: Text(aadhaarCardBChange == null
                          ? '$aadharCardB' : 'Aadhaar card back is picked',
                        style: TextStyle(
                            fontFamily: FontType.MontserratRegular,
                            color: aadhaarCardBChange == null ? Colors.black87 : hsPrime,
                            fontSize: 10),
                      ),
                      trailing: Container(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                            userStatus == '0' ? TextButton(
                                onPressed: ()async {
                                  var aadhaarCardBack = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    aadhaarCardBChange = aadhaarCardBack;
                                  });
                                },
                                child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                            ) : Container()
                          ],
                        ),
                      ),
                      children: [
                        aadharCardBImg == 'null' ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Image not found"),
                        ) : Image.network(
                          '$aadharCardBImg',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      title: const Text("Address proof",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                      subtitle: Text(addressChange == null
                          ? '$addressProfe' : 'Address proof is picked',
                        style: TextStyle(
                            fontFamily: FontType.MontserratRegular,
                            color: addressChange == null ? Colors.black87 : hsPrime,
                            fontSize: 10),
                      ),
                      trailing: Container(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                            userStatus == '0' ? TextButton(
                                onPressed: ()async{
                                  var addressProofCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    addressChange = addressProofCamera;
                                  });
                                },
                                child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                            ) : Container()
                          ],
                        ),
                      ),
                      children: [
                        addressProfeImg == 'null' ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Image not found"),
                        ) : Image.network(
                          '$addressProfeImg',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      title: const Text("Cheque image",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                      subtitle: Text(chequeChange == null
                          ? '$chequeFile' : 'Cheque img is picked',
                        style: TextStyle(
                            fontFamily: FontType.MontserratRegular,
                            color: chequeChange == null ? Colors.black87 : hsPrime,
                            fontSize: 10),
                      ),
                      trailing: Container(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                            userStatus == '0' ? TextButton(
                                onPressed: ()async{
                                  var chequeFileCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    chequeChange = chequeFileCamera;
                                  });
                                },
                                child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                            ) : Container()
                          ],
                        ),
                      ),
                      children: [
                        chequeImg == 'null' ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Image not found"),
                        ) : Image.network(
                          '$chequeImg',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      title: const Text("GST file image",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                      subtitle: Text(gstFileChange == null
                          ? '${gstFile == 'null' ? 'N/A' : gstFile}' : 'GST img is picked',
                        style: TextStyle(
                            fontFamily: FontType.MontserratRegular,
                            color: gstFileChange == null ? Colors.black87 : hsPrime,
                            fontSize: 10),
                      ),
                      trailing: Container(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                            userStatus == '0' ? TextButton(
                                onPressed: ()async{
                                  var gstImgCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    gstFileChange = gstImgCamera;
                                  });
                                },
                                child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                            ) : Container()
                          ],
                        ),
                      ),
                      children: [
                        gstImg == 'null' ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Image not found"),
                        ) : Image.network(
                          '$gstImg',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
            userStatus == '0'? ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: hsPrime
              ),
              onPressed: (){
                if(userStatus == '0'){
                  updateProfileData(context);
                }
                else if(userStatus == '1'){
                  GetXSnackBarMsg.getWarningMsg('${AppTextHelper().notUpdateUser}');
                }
                else{
                  GetXSnackBarMsg.getWarningMsg('${AppTextHelper().userNotFound}');
                }
              },
              child: Text("Update profile",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white))
            ) : Container()
          ],
        ),*/
      ),
    );
  }

}
