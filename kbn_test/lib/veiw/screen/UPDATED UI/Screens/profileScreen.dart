import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/profileWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  Map<String, dynamic> userDetails = {};
  bool _isEditingManagerDetails = false;
  bool _isEditingCompanyDetails =
      false; // New variable for editing company details

  late TextEditingController _managerNameController;
  late TextEditingController _managerEmailController;
  late TextEditingController _addressController; // Controller for address
  late TextEditingController _websiteController; // Controller for website
  late TextEditingController _contactController; // Controller for contact
  late TextEditingController _aboutController; // Controller for about
  Uint8List? _selectedImage;
  String? _imageFilename;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      var details = await ApiServices.fetchUserDetails();
      setState(() {
        userDetails = details;
        _managerNameController =
            TextEditingController(text: details['user']['manager_name']);
        _managerEmailController =
            TextEditingController(text: details['user']['manager_email']);
        _addressController =
            TextEditingController(text: details['user']['address']);
        _websiteController =
            TextEditingController(text: details['user']['company_website']);
        _contactController =
            TextEditingController(text: details['user']['contact']);
        _aboutController =
            TextEditingController(text: details['user']['about_company']);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      _showErrorSnackBar(error.toString());
    }
  }

  void _launchURL(String sitelink) async {
    final Uri uri = Uri.parse(sitelink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $sitelink';
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $message')),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes;
        _imageFilename = pickedFile.name; // Store the filename
      });
    } else {
      setState(() {
        _selectedImage = null;
        _imageFilename = null; // Clear the filename
      });
    }
  }

  Future<void> _saveManagerDetails() async {
    try {
      var response = await ApiServices.sendManagerData(
        managerName: _managerNameController.text,
        email: _managerEmailController.text,
        selectedImage: _selectedImage,
        imageFilename: _imageFilename,
      );

      if (response.statusCode == 200) {
        _fetchUserDetails();
        setState(() {
          _isEditingManagerDetails = false;
        });
        _showErrorSnackBar('Manager details updated successfully!');
      } else {
        throw Exception('Failed to update manager details');
      }
    } catch (error) {
      _showErrorSnackBar('Error updating manager details: $error');
    }
  }

  Future<void> _saveCompanyDetails() async {
    try {
      var response = await ApiServices.sendUpdatedCompanyData(
        address: _addressController.text,
        site: _websiteController.text,
        number: int.parse(_contactController.text) ,
        about: _aboutController.text,
      );

      if (response.statusCode == 200) {
        _fetchUserDetails();
        setState(() {
          _isEditingCompanyDetails = false;
        });
        _showErrorSnackBar('Company details updated successfully!');
      } else {
        throw Exception('Failed to update company details');
      }
    } catch (error) {
      _showErrorSnackBar('Error updating company details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Failed to load data"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchUserDetails,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (userDetails.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return ScaffoldBuilder(
      onMonthSelection: () {},
      currentPath: "Profile",
      pageName: "Profile",
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            profile_details(context),
            const SizedBox(height: 20),
            if (isCompany) companyManagerWidget(),
            const SizedBox(height: 20),
            companyDetailsWidget(),
          ],
        ),
      ),
    );
  }

  Widget companyManagerWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              //edit manger image

              if (_isEditingManagerDetails)
                GestureDetector(
                  onTap: () {
                    _selectImage();
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: _selectedImage != null
                        ? Image.memory(_selectedImage!)
                        : (userDetails['user']['manager_profile_image'] ==
                                    null ||
                                userDetails['user']['manager_profile_image']
                                    .isEmpty
                            ? const Image(image: AssetImage(personPng))
                            : Image.network(
                                "${ApiServices.baseUrl}/${userDetails['user']['manager_profile_image']}")),
                  ),
                )
              else
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: _selectedImage != null
                      ? Image.memory(_selectedImage!)
                      : (userDetails['user']['manager_profile_image'] == null ||
                              userDetails['user']['manager_profile_image']
                                  .isEmpty
                          ? const Image(image: AssetImage(personPng))
                          : Image.network(
                              fit: BoxFit.cover,
                              "${ApiServices.baseUrl}/${userDetails['user']['manager_profile_image']}")),
                ),

              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _managerNameController,
                      decoration: const InputDecoration(
                          labelText: managerName,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      readOnly: !_isEditingManagerDetails,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _managerEmailController,
                      decoration: const InputDecoration(
                          labelText: managerMail,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      readOnly: !_isEditingManagerDetails,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              if (_isEditingManagerDetails)
                ElevatedButton(
                  onPressed: _saveManagerDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: AppTextStyle.bodytextwhite,
                  ),
                ),
              if (!_isEditingManagerDetails)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditingManagerDetails = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Edit",
                    style: AppTextStyle.bodytextwhite,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget companyDetailsWidget() {
;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Company Details",
            style: AppTextStyle.twenty_w500,
          ),
          const SizedBox(height: 10),
          if (_isEditingCompanyDetails)
            Column(
              children: [
                TextField(maxLines: 5,
                  controller: _aboutController,
                  decoration: const InputDecoration(labelText: "About"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _websiteController,
                  decoration: const InputDecoration(labelText: "Website"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: "Contact"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveCompanyDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: AppTextStyle.bodytextwhite,
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    isCompany
                        ? (userDetails['user']['about_company'] != null &&
                                userDetails['user']['about_company'].isNotEmpty
                            ? "About\n${userDetails['user']['about_company']}"
                            : addAbout)
                        :"About KBN",
                    style: AppTextStyle.fourteenW400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    isCompany
                        ? (userDetails['user']['address'] != null &&
                                userDetails['user']['address'].isNotEmpty
                            ? "Address\n${userDetails['user']['address']}"
                            : addAddress)
                        :kbnAddress,
                    style: AppTextStyle.fourteenW400,
                  ),
                ),
                GestureDetector(
                  onTap: () => _launchURL(kbnSite), // Navigate to the website
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      isCompany
                          ? (userDetails['user']['company_website'] != null &&
                                  userDetails['user']['company_website']
                                      .isNotEmpty
                              ? "Website\n${userDetails['user']['company_website']}"
                              : addWebsite)
                          : kbnSite,
                      style: AppTextStyle.fourteenW400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                      isCompany
                          ? "Contact\n${userDetails['user']['contact']}"
                          : kbnNum,
                      style: AppTextStyle.fourteenW400),
                ),
                const SizedBox(height: 10),
                if (isCompany)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditingCompanyDetails = true; // Enable editing
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Edit",
                        style: AppTextStyle.bodytextwhite,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
