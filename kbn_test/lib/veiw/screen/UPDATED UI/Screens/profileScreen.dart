import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/companyDetailsEdits.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/companyManagerEdit.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/companyProfileSubVeiws.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  List<Widget> companyWidgets = [];
  bool _showCompanyManagerForm = true;
  bool _showCompanyDetails = true;
  bool _isEditingCompanyDetails = false;
  Map<String, dynamic> userDetails = {};
  bool _isLoading = true; // Loading state variable

  @override
  void initState() {
    super.initState();
    _fetchUserDetails(); // Fetch user details when the screen initializes
  }

  Future<void> _fetchUserDetails() async {
    try {
      var details = await ApiServices.fetchUserDetails(); // Fetch user details
      setState(() {
        userDetails = details; // Store the fetched user details
        _isLoading = false; // Update loading state
      });
    } catch (error) {
      setState(() {
        _isLoading = false; // Update loading state even if there's an error
      });
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
              // Remove the EditableCompanyAndManager widget after saving
              companyWidgets.removeWhere((widget) => widget is EditableCompanyAndManager);

              // Add non-editable company manager display widget
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
      _isEditingCompanyDetails = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userDetails.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return ScaffoldBuilder(
      currentPath: "Profile",
      pageName: "Profile",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
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
                        // Handle future updates if necessary
                      },
                    ),
                ],
              ),
              if (_showCompanyDetails)
                _isEditingCompanyDetails
                    ? EditableCompanyDetails(
                        onSave: (address, site, number) {
                          setState(() {
                            _isEditingCompanyDetails = false;
                          });
                        },
                      )
                    : companyDetails(
                        context,
                        label: "Company Details",
                        sub: "${userDetails['user']['address']}",
                        site: "${userDetails['user']['company_website']}",
                        numb: "${userDetails['user']['contact']}",
                        onSave: (updatedLabel) {
                          // Handle future updates if necessary
                        },
                      ),
            ],
          ),
        ],
      ),
    );
  }

  Widget companyDetails(
    BuildContext context, {
    required String label,
    required String sub,
    required String numb,
    required String site,
    required ValueChanged<String> onSave,
  }) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: size.width > 900 ? (size.width - 225) *  0.4 : null,
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
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: editCompanyData, // Edit company data
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.teal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Edit",
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

  // Companies details
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
                    image: userDetails['user']['manager_profile_image'] == null ||
                            userDetails['user']['manager_profile_image']
                                .isEmpty
                        ? const AssetImage(personPng)
                        : NetworkImage(
                            "${ApiServices.baseUrl}/${userDetails['user']['manager_profile_image']}")
                                as ImageProvider,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userDetails['user']['name']}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${userDetails['user']['manager_name']}" != "null"
                            ? sub
                            : "Manager Name",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                          onPressed: addNewCompany, // Handle adding a new company
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