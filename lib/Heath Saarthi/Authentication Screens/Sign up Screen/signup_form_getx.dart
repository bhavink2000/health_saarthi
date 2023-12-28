
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../App Helper/Frontend Helper/File Picker/file_image_picker.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../App Helper/Frontend Helper/Text Helper/test_helper.dart';
import '../../App Helper/Getx Helper/Auth Getx/sign_up_getx.dart';
import '../../App Helper/Getx Helper/location_getx.dart';
import '../../App Helper/Widget Helper/location_selection.dart';
import 'signup_screen.dart';

class SignUpFormGetX extends StatefulWidget {
  const SignUpFormGetX({super.key});

  @override
  State<SignUpFormGetX> createState() => _SignUpFormGetXState();
}

class _SignUpFormGetXState extends State<SignUpFormGetX> {

  final controller = Get.put(SignUpGetX());
  final locationController = Get.put(LocationCall());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final IconData iconData = IconData(0xf6ec);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: DropdownButtonFormField<String>(
                value: controller.selectedB2b?.value,
                style: const TextStyle(fontSize: 12,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'B2B Sub Admin',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 12,
                  ),
                ),
                onChanged: (newValue) {
                  controller.selectedB2b?.value = newValue!;
                },
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Select B2B subadmin'),
                  ),
                  ...controller.b2bSubAdminList?.map((subAdmin) => DropdownMenuItem(
                    value: subAdmin['id'].toString(),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5.w,
                        child: Text(subAdmin['name'])
                    ),
                  ))?.toList() ?? []
                ],
              ),
            ),
            SignUpTextField(
              tController: controller.vendorName,
              tName: 'Vendor name',
              tSign: '*',
              tIcon: Icons.person_pin,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Vendor name';
                }
                return null;
              },
            ),
            SignUpTextField(
              tController: controller.emailId,
              tName: 'Email id',
              tSign: '*',
              tIcon: Icons.email_rounded,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a email';
                }
                if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  return 'email id must contain at least one special character';
                }
                return null;
              },
            ),
            SignUpTextField(
              tController: controller.pharmacyName,
              tName: 'Pharmacy name',
              tSign: '*',
              tIcon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Pharmacy name';
                }
                return null;
              },
            ),
            SignUpTextField(
              tController: controller.mobile,
              tName: 'Mobile no',
              tSign: '*',
              textInputType: TextInputType.phone,
              tIcon: Icons.mobile_friendly_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter mobile number';
                }
                return null;
              },
            ),
            SizedBox(height: space),
            LocationDropdowns(
              items: locationController.stateList.where((state) => state!.stateName! != null).map((state) => state!.stateName!).toList(),
              loading: locationController.stateLoading.value,
              selectedItem: locationController.selectedState?.value,
              label: "Select state",
              onChanged: (newValue) {
                final selectedStateObject = locationController.stateList.firstWhere(
                      (state) => state!.stateName == newValue,
                  orElse: () => StateData(),
                );
                if (selectedStateObject != null) {
                  setState(() {
                    locationController.cityList.clear();
                    locationController.selectedCity?.value = '';
                    locationController.areaList.clear();
                    locationController.selectedArea?.value = '';
                    locationController.branchList.clear();
                    locationController.selectedBranch?.value = '';
                    locationController.selectedState?.value = newValue!;
                    locationController.selectedStateId?.value = selectedStateObject.id.toString();
                  });
                  locationController.fetchCityList(locationController.selectedStateId?.value);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select a state';
                }
                return null;
              },
            ),
            SizedBox(height: space),
            LocationDropdowns(
              items: locationController.cityList.where((city) => city!.cityName != null).map((city) => city!.cityName!).toList(),
              loading: locationController.cityLoading.value,
              selectedItem: locationController.selectedCity?.value,
              label: "Select city",
              onChanged: (newValue) {
                final selectedCityObject = locationController.cityList.firstWhere(
                      (city) => city!.cityName == newValue,
                  orElse: () => CityData(), // Return an empty instance of StateData
                );
                if (selectedCityObject != null) {
                  setState(() {
                    locationController.selectedCity?.value = '';
                    locationController.areaList.clear();
                    locationController.selectedArea?.value = '';
                    locationController.branchList.clear();
                    locationController.selectedBranch?.value = '';
                    locationController.selectedCity?.value = newValue!;
                    locationController.selectedCityId?.value = selectedCityObject.id.toString();
                    locationController.fetchBranchList(locationController.selectedStateId?.value, locationController.selectedCityId?.value, '');
                  });
                  locationController.fetchAreaList(locationController.selectedStateId?.value, locationController.selectedCityId?.value);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select a city';
                }
                return null;
              },
            ),
            SizedBox(height: space),
            LocationDropdowns(
              items: locationController.branchList.where((branch) => branch!.branchName != null).map((branch) => branch!.branchName!).toList(),
              loading: locationController.branchLoading.value,
              selectedItem: locationController.selectedBranch?.value,
              label: "Select branch",
              onChanged: (newValue) {
                final selectedBranchObject = locationController.branchList.firstWhere(
                      (branch) => branch!.branchName == newValue,
                  orElse: () => BranchData(), // Return an empty instance of StateData
                );
                if (selectedBranchObject != null) {
                  setState(() {
                    locationController.selectedBranch?.value = newValue!;
                    locationController.selectedBranchId?.value = selectedBranchObject.id.toString();
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select a branch';
                }
                return null;
              },
            ),
            SizedBox(height: space),
            LocationDropdowns(
              items: locationController.areaList.where((area) => area!.areaName != null).map((area) => area!.areaName!).toList(),
              loading: locationController.areaLoading.value,
              selectedItem: locationController.selectedArea?.value,
              label: "Select area",
              onChanged: (newValue) {
                final selectedAreaObject = locationController.areaList.firstWhere(
                      (area) => area!.areaName == newValue,
                  orElse: () => AreaData(), // Return an empty instance of StateData
                );
                if (selectedAreaObject != null) {
                  setState(() {
                    locationController.branchList.clear();
                    locationController.selectedBranch?.value = '';
                    locationController.selectedArea?.value = newValue!;
                    locationController.selectedAreaId?.value = selectedAreaObject.id.toString();
                    locationController.fetchBranchList(
                        locationController.selectedStateId?.value,
                        locationController.selectedCityId?.value,
                        locationController.selectedAreaId?.value
                    );
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select a area';
                }
                return null;
              },
            ),
            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: controller.selectedSales?.value,
                style: const TextStyle(fontSize: 10,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sales executive"),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a sales executive';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    controller.showExecutive.value = true;
                    controller.selectedSales?.value = newValue!;
                    // Retrieve the selected executive using the ID
                    final selectedExecutive = controller.salesExecutiveList.firstWhere(
                          (executive) => executive['id'].toString() == newValue,
                      orElse: () => null,
                    );
                    if (selectedExecutive != null) {
                      final selectedId = selectedExecutive['id'].toString();
                      //controller.selectedSalesMobileNo?.value = selectedExecutive['mobile_no'];
                      controller.seMobile.value = selectedExecutive['mobile_no'];
                    }
                    //controller.seMobile = controller.selectedSalesMobileNo;
                  });
                },
                items: controller.salesExecutiveList?.map((sales) => DropdownMenuItem(
                  value: sales['id'].toString(),
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1.45.w,
                      child: Text("${sales['name']} - ${sales['mobile_no']}")
                  ),
                ))?.toList() ?? [],
              ),
            ),
            SizedBox(height: space),
            Visibility(
              visible: controller.showExecutive.value,
              child: SignUpTextField(
                tController: controller.seMobile,
                tName: 'Executive mobile no',
                tSign: '',
                tIcon: Icons.mobile_friendly,
                textInputType: TextInputType.phone,
              ),
            ),

            Icon(iconData),
            SignUpTextField(
              tController: controller.pinCode,
              tName: 'PIN code',
              tSign: '',
              tIcon: Icons.code,
              textInputType: TextInputType.number,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height / 5,
              //color: Colors.green,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            controller.aadhaarCardFFile == null
                                ? const Text("Aadhaar card front",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                : Container(
                                alignment: Alignment.centerLeft,
                                width: controller.aadhaarCardFFile!.path.split('/').last.toString().split('.').last == 'pdf' ? 200: 100,height: 50,
                                child: controller.aadhaarCardFFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                    ? Text(controller.aadhaarCardFFile!.path.split('/').last.toString(),style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                    : controller.buildImageDialog(controller.aadhaarCardFFile!, 'Aadhaar card front')
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () async {
                                  var aadhaarCardFrontFile = await FileImagePicker().pickFileManager(context);
                                  setState(() {
                                    controller.aadhaarCardFFile = aadhaarCardFrontFile;
                                  });
                                },
                                icon: const Icon(
                                    Icons.file_copy_rounded
                                )
                            ),
                            IconButton(
                                onPressed: () async{
                                  var aadhaarCardFrontCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    controller.aadhaarCardFFile = aadhaarCardFrontCamera;
                                  });
                                },
                                icon: const Icon(
                                    Icons.camera_alt_rounded
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            controller.aadhaarCardBFile == null
                                ? const Text("Aadhaar card back",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                : Container(
                                alignment: Alignment.centerLeft,
                                width: controller.aadhaarCardBFile!.path.split('/').last.toString().split('.').last == 'pdf' ? 200: 100,height: 50,
                                child: controller.aadhaarCardBFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                    ? Text(controller.aadhaarCardBFile!.path.split('/').last.toString(),style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                    : controller.buildImageDialog(controller.aadhaarCardBFile!, 'Aadhaar card back')
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: ()async {
                                  var aadhaarCardBack = await FileImagePicker().pickFileManager(context);
                                  setState(() {
                                    controller.aadhaarCardBFile = aadhaarCardBack;
                                  });
                                },
                                icon: const Icon(
                                    Icons.file_copy_rounded
                                )
                            ),
                            IconButton(
                                onPressed: ()async{
                                  var aadhaarCardBackCamera = await FileImagePicker().pickCamera(context);
                                  setState(() {
                                    controller.aadhaarCardBFile = aadhaarCardBackCamera;
                                  });
                                },
                                icon: const Icon(
                                    Icons.camera_alt_rounded
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SignUpTextField(
              tController: controller.address,
              tName: 'Address',
              tSign: '*',
              tIcon: Icons.location_city,
              maxLine: 4,minLine: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter address';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        controller.addressFile == null
                            ? const Text("Address proof",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                            alignment: Alignment.centerLeft,
                            width: controller.addressFile!.path.split('/').last.toString().split('.').last == 'pdf' ? 200 : 100,height: 50,
                            child: controller.addressFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                ? Text(controller.addressFile!.path.split('/').last.toString(),style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                : controller.buildImageDialog(controller.addressFile!, 'Address proof')
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: ()async {
                              var addressProof = await FileImagePicker().pickFileManager(context);
                              setState(() {
                                controller.addressFile = addressProof;
                              });
                            },
                            icon: const Icon(
                                Icons.file_copy_rounded
                            )
                        ),
                        IconButton(
                            onPressed: () async{
                              var addressProofCamera = await FileImagePicker().pickCamera(context);
                              setState(() {
                                controller.addressFile = addressProofCamera;
                              });
                            },
                            icon: const Icon(
                                Icons.camera_alt_rounded
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SignUpTextField(
              tController: controller.panCardNo,
              maxLength: 10,
              textInputType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.characters,
              tName: 'Pan Card number',
              tSign: '*',
              tIcon: Icons.numbers_rounded,
              validator: controller.validatePANCard,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        controller.panCardFile == null
                            ? const Text("PAN card",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                            alignment: Alignment.centerLeft,
                            width: controller.panCardFile!.path.split('/').last.toString().split('.').last == 'pdf' ? 200 : 100,height: 50,
                            child: controller.panCardFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                ? Text(controller.panCardFile!.path.split('/').last.toString(),style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                : controller.buildImageDialog(controller.panCardFile!, 'PAN card')
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: ()async {
                              var panCardFileManger = await FileImagePicker().pickFileManager(context);
                              setState(() {
                                controller.panCardFile = panCardFileManger;
                              });
                            },
                            icon: const Icon(
                                Icons.file_copy_rounded
                            )
                        ),
                        IconButton(
                            onPressed: () async{
                              var panCardCamera = await FileImagePicker().pickCamera(context);
                              setState(() {
                                controller.panCardFile = panCardCamera;
                              });
                            },
                            icon: const Icon(
                                Icons.camera_alt_rounded
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SignUpTextField(
              tController: controller.gstNo,
              textInputType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.characters,
              tName: 'GST number',
              tSign: '*',
              tIcon: Icons.confirmation_num_rounded,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        controller.gstFile == null
                            ? const Text("GST img",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                            alignment: Alignment.centerLeft,
                            width: controller.gstFile!.path.split('/').last.toString().split('.').last == 'pdf' ? 200 :100,height: 50,
                            child: controller.gstFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                ? Text(controller.gstFile!.path.split('/').last.toString(),style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                : controller.buildImageDialog(controller.gstFile!, 'GST file')
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: ()async {
                              var gstFileManger = await FileImagePicker().pickFileManager(context);
                              setState(() {
                                controller.gstFile = gstFileManger;
                              });
                            },
                            icon: const Icon(
                                Icons.file_copy_rounded
                            )
                        ),
                        IconButton(
                            onPressed: () async{
                              var gstFileCamera = await FileImagePicker().pickCamera(context);
                              setState(() {
                                controller.gstFile = gstFileCamera;
                              });
                            },
                            icon: const Icon(
                                Icons.camera_alt_rounded
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SignUpTextField(
              tController: controller.bankName,
              tName: 'Bank name',
              tSign: '*',
              tIcon: Icons.account_balance_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter bank name';
                }
                return null;
              },
            ),
            SignUpTextField(
              tController: controller.ifscCode,
              maxLength: 11,
              textInputType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.characters,
              tName: 'IFSC code',
              tSign: '*',
              tIcon: Icons.code_rounded,
              validator: controller.validateIFSC,
            ),
            SignUpTextField(
              tController: controller.beneficiaryName,
              tName: 'Beneficiary name as par cheque',
              tSign: '*',
              tIcon: Icons.account_balance_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter beneficiary name';
                }
                return null;
              },
            ),
            SignUpTextField(
              tController: controller.accountNo,
              maxLength: 20,
              textInputType: TextInputType.number,
              tName: 'Account number',
              tSign: '*',
              tIcon: Icons.account_balance_wallet_rounded,
              validator: controller.validateAccountNumber,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.password,
                obscureText: controller.obscured.value,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Password"),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.lock_open_rounded, color: hsBlack,size: 20),
                  suffixIcon: InkWell(
                    onTap: controller.togglePasswordView,
                    child: Icon(
                      controller.obscured.value
                          ?
                      Icons.visibility_off_rounded
                          :
                      Icons.visibility_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                    // Password meets all the requirements
                  } else {
                    print('Password does not meet the requirements.');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a password';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one special character';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.cPassword,
                obscureText: controller.obCScured.value,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Confirm password"),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: hsBlack,size: 20),
                  suffixIcon: InkWell(
                    onTap: controller.toggleCPasswordView,
                    child: Icon(
                      controller.obCScured.value
                          ?
                      Icons.visibility_off_rounded
                          :
                      Icons.visibility_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                    // Password meets all the requirements
                  } else {
                    print('Password does not meet the requirements.');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a confirm password';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one special character';
                  }
                  if (value != controller.password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: controller.agreedToTOS.value,
                    onChanged: controller.setAgreedToTOS,
                  ),
                  GestureDetector(
                    onTap: () => controller.setAgreedToTOS(!controller.agreedToTOS.value),
                    child: const Text(
                      'I agree to the Terms of Condition and \nPrivacy Policy',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: InkWell(
                onTap: ()async{
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    if(locationController.selectedState == null || locationController.selectedCity == null
                        || locationController.selectedArea == null || locationController.selectedBranch == null || locationController.selectedState?.value == ''
                        || locationController.selectedCity?.value == '' || locationController.selectedArea?.value == '' || locationController.selectedBranch?.value == ''){
                      GetXSnackBarMsg.getWarningMsg('Please select location fields');
                    }
                    else if(controller.panCardFile == null){
                      GetXSnackBarMsg.getWarningMsg(AppTextHelper().panCardSelect);
                    }
                    else if(controller.addressFile == null){
                      GetXSnackBarMsg.getWarningMsg(AppTextHelper().addressSelect);
                    }
                    else if(controller.aadhaarCardFFile == null){
                      GetXSnackBarMsg.getWarningMsg(AppTextHelper().aadhaarCardFSelect);
                    }
                    else if(controller.aadhaarCardBFile == null){
                      GetXSnackBarMsg.getWarningMsg(AppTextHelper().aadhaarCardBSelect);
                    }
                    else if(controller.checkFile == null){
                      GetXSnackBarMsg.getWarningMsg(AppTextHelper().chequeImgSelect);
                    }
                    else if(controller.agreedToTOS.value == false){
                      GetXSnackBarMsg.getWarningMsg('Please select term & condition');
                    }
                    else{
                      setState(() {
                        controller.isSigningUp.value = true;
                      });
                      await controller.signUpData();
                      setState(() {
                        controller.isSigningUp.value = false;
                      });
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsBlack),
                  alignment: Alignment.center,
                  child: controller.isSigningUp.value == true
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Processing : ${controller.loadingProgress.toStringAsFixed(1)}%',style: const TextStyle(color: Colors.white),),
                      const SizedBox(width: 15),
                      const CircularProgressIndicator(color: Colors.white),
                    ],
                  ) // Show loading indicator
                      : const Text(
                    "Create an account",
                    style: TextStyle(
                      fontFamily: FontType.MontserratMedium,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: space),
          ],
        ),
      ),
    );
  }
}
