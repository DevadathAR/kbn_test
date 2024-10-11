import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  List<Widget> companyWidgets = [];
  //  List<Widget> compan = []; // List to store company manager widgets
  bool _showCompanyManagerForm = true;
  bool _showCompanyDetails = true;
  Map<String, dynamic> userDetails = {};
  bool _isLoading = true; // Loading state variable

  void initState() {
    super.initState();
    _fetchUserDetails(); // Fetch user details when the screen initializes
  }

  Future<void> _fetchUserDetails() async {
    try {
      var details = await ApiServices
          .fetchUserDetails(); // Call the fetchUserDetails method
      setState(() {
        userDetails = details; // Store the fetched user details
        _isLoading = false; // Update loading state
      });
    } catch (error) {
      // Handle errors if needed
      setState(() {
        _isLoading = false; // Update loading state even if there's an error
      });
      print('Error fetching user details: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user details: $error')),
      );
    }
  }

  // Function to add a new company manager widget
  void addNewCompany() {
    setState(() {
      _showCompanyManagerForm = false;
      companyWidgets.add(
        EditableCompanyAndManager(
          onSave: (label, sub, email) {
            setState(() {
              // Find the EditableCompanyAndManager that triggered onSave and remove it
              companyWidgets
                  .removeWhere((widget) => widget is EditableCompanyAndManager);

              // Optionally, add a non-editable version or another widget after saving
              companyWidgets.add(
                companyAndManager(
                  context,
                  sub: sub,
                  email: email,
                  onSave: (updatedLabel) {
                    // Handle future updates if necessary
                  },
                ),
              );
            });
          },
        ),
      );
    });
  }
void editCompanyData() {
  setState(() {
    _showCompanyDetails = false;

    // Add EditableCompanyDetails widget for editing
    companyWidgets.add(
      EditableCompanyDetails(
        onSave: (address, site, number) {
          setState(() {
            // Remove the EditableCompanyDetails widget after saving
            companyWidgets.removeWhere((widget) => widget is EditableCompanyDetails);

            // Add the company details widget with the updated information
            companyWidgets.add(
              companyDetails(
                context,
                label: "Company Details", // You can replace this with the actual company name if available
                sub: address,
                site: site,
                numb: number,
                
              ),
            );
          });
        },
      ),
    );
  });
}

  

  

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isCompany) {
      if (userDetails == null) {
        return const Center(child: Text("No data available"));
      }
    } else {
      if (userDetails == null) {
        return const Center(child: Text("No data available"));
      }
    }

    return ScaffoldBuilder(
        currentPath: "Profile",
        pageName: "Profile",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    companyShortView(context),
                    const SizedBox(height: 5),
                    ...companyWidgets,
                    if (_showCompanyManagerForm)
                      companyAndManager(
                        context,
                        sub: "${userDetails['user']['manager_name']}",
                        email: "${userDetails['user']['manager_email']}",
                        onSave: (updatedLabel) {
                          print("Updated label: $updatedLabel");
                        },
                      )
                  ],
                ),
                if(_showCompanyDetails)
                companyDetails(context,
                    label: "Company Details",
                    sub: "${userDetails['user']['address']}",
                    site: "${userDetails['user']['company_website']}",
                    numb: "${userDetails['user']['contact']}"),
              ],
            )
          ],
        ));
  }


  
Widget companyDetails(context, {label, sub, isview, numb, site}) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      width: size.width > 900 ? (size.width - 225) * 0.4 : null,
      // height: size.height * 0.5,
      height: 455,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    label,
                    style: AppTextStyle.twenty_w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    sub,
                    style: AppTextStyle.fourteenW400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    numb,
                    style: AppTextStyle.fourteenW400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    site,
                    style: AppTextStyle.fourteenW400,
                  ),
                )
              ],
            ),
          ),
          Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {editCompanyData();
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
        ],
      ),
    ),
  );
}

  //companies details
  Widget companyAndManager(
    BuildContext context, {
    required String sub,
    required String email, // New email parameter
    required ValueChanged<String> onSave, // Callback to save the updated data
  }) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        width: size.width > 900 ? (size.width - 200) * .6 : null,
        height: 250,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Text to show last updated date
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, right: 8),
                child: Text(
                  "Last updated date",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),

            // Image box and other details
            Row(
              children: [
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.transparent,
                    ),
                    child: Image(
                      image: userDetails['user']['manager_profile_image'] ==
                                  null ||
                              userDetails['user']['manager_profile_image']
                                  .isEmpty
                          ? const AssetImage(personPng)
                          : NetworkImage(
                                  "${ApiServices.baseUrl}/${userDetails['user']['manager_profile_image']}")
                              as ImageProvider,
                    )),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display label as text
                      Text(
                        "${userDetails['user']['name']}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Display sub as text
                      Text(
                        "${userDetails['user']['manager_name']}" != "null"
                            ? sub
                            : "Manager Name",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Display email as text
                      Text(
                        "${userDetails['user']['manager_email']}" != "null"
                            ? email
                            : "Manager mail ID",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed:
                              addNewCompany, // Handle adding a new company
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            side: const BorderSide(color: tealblue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "${userDetails['user']['manager_email']}" == "null"
                                ? "Add"
                                : "Edit",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditableCompanyAndManager extends StatefulWidget {
  final Function(String, String, String) onSave;

  const EditableCompanyAndManager({required this.onSave, Key? key})
      : super(key: key);

  @override
  _EditableCompanyAndManagerState createState() =>
      _EditableCompanyAndManagerState();
}

class _EditableCompanyAndManagerState extends State<EditableCompanyAndManager> {
  final TextEditingController _subController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final ApiServices _apiService = ApiServices(); // API service instance

  Uint8List? _selectedImage;
  File? _imageFilename;

  // Function to handle form submission
  Future<void> _submitData() async {
    // Validate the fields before sending data
    if (_subController.text.isEmpty || _emailController.text.isEmpty) {
      // You can display an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    try {
      // Call the API service to send data to the server
      var response = await _apiService.sendManagerData(
        managerName: _subController.text,
        email: _emailController.text,
        imageFile: _imageFilename, // Can be null if no image is selected
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saved successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to save data: ${response.statusCode}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes;
        // _imageFilename = pickedFile.name; // Store the filename
      });
    } else {
      setState(() {
        _selectedImage = null;
        _imageFilename = null; // Clear the filename
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: size.width > 900 ? (size.width - 200) * .6 : null,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
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
                  color: Colors.transparent,
                ),
                child: _selectedImage != null
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(_selectedImage!),
                      )
                    : Image.asset(personPng),
              ),
            ),
            SizedBox(
              width: size.width > 900 ? (size.width - 200) * .45 : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${userDetails['user']['name']}",
                      style: AppTextStyle.sixteen_w400_black,
                    ),
                  ),
                  TextFormField(
                    controller: _subController,
                    decoration: const InputDecoration(
                      labelText: "Manager Name",
                      border: InputBorder.none,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitData(); // Call the function to submit data
                        widget.onSave(
                          "${userDetails['user']['name']}",
                          _subController.text,
                          _emailController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget companyShortView(BuildContext context, {label, sub, email}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width > 900 ? (size.width - 200) * .6 : null,
    height: 200,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      color: white,
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text to show last updated date
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 8.0, right: 8),
            child: Text(
              "Last updated date",
              style: AppTextStyle.normalText,
            ),
          ),
        ),

        // Image box and other details
        Row(
          children: [
            Container(
              width: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
                ),
                radius: 50,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        "${userDetails['user']['name']}",
                        style: AppTextStyle.fourteenW400,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text("${userDetails['user']['kbn_code']}",
                            style: AppTextStyle.normalText),
                      )),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text("${userDetails['user']['email']}",
                          style: AppTextStyle.normalText),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: viewProfile(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget viewProfile(BuildContext context) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: SizedBox(
        width: 150, // Set the width to 250
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: tealblue,
            shape: RoundedRectangleBorder(
              // Creates rounded corner buttons
              borderRadius: BorderRadius.circular(10), // Adjust corner radius
            ),
          ),
          child: const Text(
            "View Profile",
            style: AppTextStyle.bodytextwhite,
          ),
        ),
      ),
    ),
  );
}

class EditableCompanyDetails extends StatefulWidget {
  final Function(String, String, String) onSave;

  const EditableCompanyDetails({required this.onSave, Key? key})
      : super(key: key);

  @override
  _EditableCompanyDetailsState createState() => _EditableCompanyDetailsState();
}

class _EditableCompanyDetailsState extends State<EditableCompanyDetails> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _numbController = TextEditingController();

  final ApiServices _apiService = ApiServices(); // API service instance

  // Function to handle form submission
  Future<void> _submitCompanyData() async {
    // Validate the fields before sending data
    if (_addressController.text.isEmpty || _siteController.text.isEmpty|| _numbController.text.isEmpty) {
      // You can display an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    try {
      // Call the API service to send data to the server
      var response = await _apiService.sendUpdatedCompanyData(
        address: _addressController.text,
        site: _siteController.text,
        number: int.parse(_numbController.text),);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saved successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to save data: ${response.statusCode}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Align(alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: size.width > 900 ? (size.width - 225) * 0.4 : null,
        height: 455,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              SizedBox(
                width: size.width > 900 ? (size.width - 200) * .45 : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                       "Company Details",
                        style: AppTextStyle.sixteen_w400_black,
                      ),
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: "Address",
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      controller: _siteController,
                      decoration: const InputDecoration(
                        labelText: "web site",
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      controller: _numbController,
                      decoration: const InputDecoration(
                        labelText: "Number",
                        border: InputBorder.none,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitCompanyData(); // Call the function to submit data
                          widget.onSave(
                            _addressController.text,
                            _siteController.text,
                            _numbController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
