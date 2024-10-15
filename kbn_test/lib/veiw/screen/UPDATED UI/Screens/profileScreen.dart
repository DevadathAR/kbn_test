import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/companyProfileSubVeiws.dart';

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
  bool _isEditingCompanyDetails = false; // New variable for editing company details

  late TextEditingController _managerNameController;
  late TextEditingController _managerEmailController;
  late TextEditingController _addressController; // Controller for address
  late TextEditingController _websiteController; // Controller for website
  late TextEditingController _contactController; // Controller for contact
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
        _managerNameController = TextEditingController(text: details['user']['manager_name']);
        _managerEmailController = TextEditingController(text: details['user']['manager_email']);
        _addressController = TextEditingController(text: details['user']['address']);
        _websiteController = TextEditingController(text: details['user']['company_website']);
        _contactController = TextEditingController(text: details['user']['contact']);
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $message')),
    );
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() async {
        _selectedImage = await image.readAsBytes();
        _imageFilename = image.name;
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
      number: _contactController.text,
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
      currentPath: "Profile",
      pageName: "Profile",
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            companyShortView(context),
            const SizedBox(height: 20),
            companyManagerWidget(),
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
                            userDetails['user']['manager_profile_image'].isEmpty
                        ? const Image(image: AssetImage(personPng))
                        : Image.network("${ApiServices.baseUrl}/${userDetails['user']['manager_profile_image']}")),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _managerNameController,
                      decoration: const InputDecoration(labelText: 'Manager Name'),
                      readOnly: !_isEditingManagerDetails,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _managerEmailController,
                      decoration: const InputDecoration(labelText: 'Manager Email'),
                      readOnly: !_isEditingManagerDetails,
                    ),
                    const SizedBox(height: 10),
                    if (_isEditingManagerDetails)
                      TextButton.icon(
                        onPressed: _selectImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Select Image"),
                      ),
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
                  child:  Text("Save",style: AppTextStyle.bodytextwhite,),
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
                  child: const Text("Edit",style: AppTextStyle.bodytextwhite,),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget companyDetailsWidget() {
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
                  child: const Text("Save",style: AppTextStyle.bodytextwhite,),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address: ${userDetails['user']['address']}", style: AppTextStyle.fourteenW400),
                Text("Website: ${userDetails['user']['company_website']}", style: AppTextStyle.fourteenW400),
                Text("Contact: ${userDetails['user']['contact']}", style: AppTextStyle.fourteenW400),
                const SizedBox(height: 10),
                Align(alignment: Alignment.bottomCenter,
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
                    child: const Text("Edit",style: AppTextStyle.bodytextwhite,),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
