import 'package:flutter/material.dart';
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

  List<Widget> companyWidgets = []; // List to store company manager widgets

  // Function to add a new company manager widget
  void addNewCompany() {
    setState(() {
      companyWidgets.add(
        EditableCompanyAndManager(
          onSave: (label, sub, email) {
            // Replace the editable widget with a non-editable one upon save
            setState(() {
              companyWidgets.add(NonEditableCompanyAndManager(
                label: label,
                sub: sub,
                email: email,
              ));
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    

    return ScaffoldBuilder(
        currentPath: "Profile",
        pageName: "Profile",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),

            // PageAndDate(context, pageLabel: "Profile"),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    companyShortView(context),
                    const SizedBox(height: 5),
                    ...companyWidgets,
                  //   ElevatedButton(
                  //   onPressed: addNewCompany,
                  //   child: const Text("Add Company and Manager"),
                  // ),
                    companyAndManager(
                      context,
                      label: "Company Name",
                      sub: "Manager Name",
                      email: "manager@example.com",
                      onSave: (updatedLabel) {
                        print("Updated label: $updatedLabel");
                      },
                    )
                  ],
                ),
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
  Widget companyAndManager(
  BuildContext context, {
  required String label,
  required String sub,
  required String email, // New email parameter
  required ValueChanged<String> onSave, // Callback to save the updated data
}) {
  Size size = MediaQuery.of(context).size;

  return Container(
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
              style: AppTextStyle.normalText, // Adjust as per your AppTextStyle
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
              child: const Image(
                  image: AssetImage(personPng)), // Adjust the image path
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display label as text
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 16), // Adjust as per AppTextStyle
                  ),
                  const SizedBox(height: 10),
                  // Display sub as text
                  Text(
                    sub,
                    style: const TextStyle(
                        fontSize: 14), // Adjust as per AppTextStyle
                  ),
                  const SizedBox(height: 10),
                  // Display email as text
                  Text(
                    email,
                    style: const TextStyle(
                        fontSize: 14), // Adjust as per AppTextStyle
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
            onPressed: addNewCompany,
            style: ElevatedButton.styleFrom(
                            backgroundColor: tealblue,

              side: const BorderSide(color: black),
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Update",
              style: AppTextStyle.bodytextwhite,
            ),
          ),),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}

// Widget to display editable company and manager form
class EditableCompanyAndManager extends StatefulWidget {
  final Function(String, String, String) onSave;

  const EditableCompanyAndManager({required this.onSave, Key? key})
      : super(key: key);

  @override
  _EditableCompanyAndManagerState createState() =>
      _EditableCompanyAndManagerState();
}
class _EditableCompanyAndManagerState extends State<EditableCompanyAndManager> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _subController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _labelController,
              
              decoration: const InputDecoration(labelText: "Company Name",border: InputBorder.none,),
            ),

            TextFormField(
              controller: _subController,
              decoration: const InputDecoration(labelText: "Manager Name",border: InputBorder.none,),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email",border: InputBorder.none,),
            ),
            Align(
              alignment: Alignment.centerRight,
              child:Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
            onPressed: (){widget.onSave(
                    _labelController.text,
                    _subController.text,
                    _emailController.text,
                  );
                  Navigator.of(context).pop();},
            style: ElevatedButton.styleFrom(
                            backgroundColor: tealblue,

              side: const BorderSide(color: black),
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Save",
              style: AppTextStyle.bodytextwhite,
            ),
          ),),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to display non-editable company and manager details
class NonEditableCompanyAndManager extends StatelessWidget {
  final String label;
  final String sub;
  final String email;

  const NonEditableCompanyAndManager({
    required this.label,
    required this.sub,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company Name: $label"),
            Text("Manager Name: $sub"),
            Text("Email: $email"),
          ],
        ),
      ),
    );
  }
}






// Function to display the dialog for editing
void _showEditDialog(
  BuildContext context,
  String label,
  String sub,
  String email,
  ValueChanged<String> onSave,
) {
  // Text controllers for the dialog fields
  TextEditingController labelController = TextEditingController(text: label);
  TextEditingController subController = TextEditingController(text: sub);
  TextEditingController emailController = TextEditingController(text: email);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Edit Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: labelController,
              decoration: const InputDecoration(labelText: "Label"),
            ),
            TextFormField(
              controller: subController,
              decoration: const InputDecoration(labelText: "Sub"),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email ID"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () {
              // Call the save callback with the updated values
              onSave(labelController.text);
              Navigator.of(context).pop(); // Close the dialog after saving
            },
          ),
        ],
      );
    },
  );
}

Widget addAndSave(context) {
  Size size = MediaQuery.of(context).size;

  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Wrap(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: black),
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Add",
              style: AppTextStyle.bodytext_12,
            ),
          ),
          SizedBox(width: size.width * 0.005),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: tealblue,
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Save",
              style: AppTextStyle.bodytextwhite,
            ),
          ),
        ],
      ),
    ),
  );
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
          addAndSave(context)
        ],
      ),
    ),
  );
}

Widget companyShortView(BuildContext context, {label, sub, email}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width > 900 ? (size.width - 200) * .6 : null,
    height: 200,

    // height: 200,
    // height:
    //     size.height * 0.35, // Increased height to accommodate the TextFormField
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
  // Size size = MediaQuery.of(context).size;

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
