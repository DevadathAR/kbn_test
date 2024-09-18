import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/T_&_C.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Address Feild
  final TextEditingController addressTextController = TextEditingController();
  final TextEditingController mailIdController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();

// JobCreation Feild
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobSummaryController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobVacancyController = TextEditingController();
  final TextEditingController keyRespoController = TextEditingController();
  final TextEditingController requirementController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController requirementExperienceController =
      TextEditingController();

  String? selectedEmploymentType;
  String? selectedJobMode;
  String? selectedExperience;

  final List<String> employmentTypes = ['Full-Time', 'Part-Time', 'Contract'];
  final List<String> jobModes = ['On-site', 'Remote', 'Hybrid'];
  final List<String> experiences = [
    'Fresher ,0-2 years',
    'Junior level, 2-5 years',
    'Senior level, 5+ years'
  ];
  // int userId = userDetails['user']['userId'];
  String? postedJobTitle;
  String? postingDate;

  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    // fetchPostedJobDetails();

    // // Pre-fill text fields with existing user details
    addressTextController.text = userDetails['user']['address'] ?? '';
    contactController.text = userDetails['user']['contact'] ?? '';
    websiteController.text = userDetails['user']['company_website'] ?? '';
    businessTypeController.text = userDetails['user']['business_type'] ?? '';
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    addressTextController.dispose();
    contactController.dispose();
    websiteController.dispose();
    businessTypeController.dispose();
    jobTitleController.dispose();
    jobSummaryController.dispose();
    jobLocationController.dispose();
    jobVacancyController.dispose();
    keyRespoController.dispose();
    salaryController.dispose();
    educationController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  Future<void> createJob() async {
    Map<String, dynamic> jobData = {
      "title": jobTitleController.text,
      "job_summary": jobSummaryController.text,
      "experience_level": selectedExperience,
      "vacancy": int.parse(jobVacancyController.text), // Ensure valid number
      "location": jobLocationController.text,
      "job_mode": selectedJobMode,
      "salary": int.parse(salaryController.text), // Ensure valid number
      "job_type": selectedEmploymentType,
      "key_responsibilities": keyRespoController.text.split('\n'),
      "job_requirements": {
        "experience": [requirementExperienceController.text],
        "skills": [skillsController.text],
        "educational_background": [educationController.text],
      }
    };

    try {
      var response = await ApiServices.createJob(jobData);
      if (response.statusCode == 201) {
        setState(() {
          postedJobTitle = jobTitleController.text;
          postingDate =
              DateTime.now().toString().split(' ')[0]; // Store current date
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Job created successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create job")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    }
  }

  Future<void> _updateAddressDetails() async {
    try {
      // Call the API to update the details
      await ApiServices.updateAddressDetails(
        addressTextController.text,
        contactController.text,
        businessTypeController.text,
        websiteController.text,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details updated successfully!')),
      );
    } catch (e) {
      // Show error message if the API call fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update details: $e')),
      );
    }
  }

  // Validation function for required text fields
  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

// Define the validator function
  String? numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid number';
    } else if (intValue <= 0) {
      return 'Please enter a number greater than 0';
    }
    return null; // Return null if the input is valid
  }

  Future<void> fetchUserData() async {
    try {
      var userData = await ApiServices.fetchUserDetails();
      setState(() {
        userDetails = userData;
        // print("userDetails:-$userDetails");
        // userId = userDetails['user']['userId'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred while fetching user data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildAppBarSection(width),
                _buildBodySection(width),
              ],
            ),
          );
        },
      ),
    );
  }

  // rest are widgets

  // AppBar Section
  Widget _buildAppBarSection(double width) {
    return Column(
      children: [
        Image.asset(
          kbnLogo, // Kbn Logo
          height: 40,
        ),
        HomeAppBarBox(
          context,
          T_and_C: const companyT_n_C(),
          // logOutTo: const CompanyLoginPage(),
          home: const CompanyHomePage(),
          profileImage:
              "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
        ),
      ],
    );
  }

  // Body Section
  Widget _buildBodySection(double width) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _companyInfoSection(width),
          const SizedBox(width: 16),
          _buildRecruitmentDetailsSection(width),
          const SizedBox(width: 16),
          AddRecruitmentSection(width),
        ],
      ),
    );
  }

  // Company Information Section
  Widget _companyInfoSection(double width) {
    var kbnCode = userDetails['user']['kbn_code'];

    return Expanded(
      flex: width > 1200 ? 1 : 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: width * 0.08, // Responsive image size
            width: width * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage(compnyLogo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(userDetails['user']['name'], style: AppTextStyle.normalHeading),
          const SizedBox(height: 5),
          Row(children: [
            kbnCode == null
                ? const Text(
                    'KBN CODE:-',
                    style: AppTextStyle.normalTextGrey,
                  )
                : Text('$kbnCode', style: AppTextStyle.bodytext)
          ]),
          const SizedBox(height: 20),
          _buildCompanyDetailsBox(width),
        ],
      ),
    );
  }

  // Company Details Box
  Widget _buildCompanyDetailsBox(double width) {
    return Container(
      width: width * 0.3,
      height: 326,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableRow('Address'),
            const SizedBox(height: 8),
            //addressFeild
            TextFormField(
              controller: addressTextController,
              maxLines: 2,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Address",
                  border: InputBorder.none),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(userDetails['user']['email'] ?? "N/A"),
            ),
            // _buildEditableTextField(
            //     hint: userDetails['user']['email'] ?? "N/A"),
            const SizedBox(height: 8),
            _buildEditableTextField(
                controller: contactController, hint: "Contact"),
            const SizedBox(height: 8),
            _buildEditableTextField(
                controller: websiteController, hint: "Website Link"),
            const SizedBox(height: 8),
            _buildEditableTextField(
                controller: businessTypeController, hint: "Business Type"),
            const SizedBox(height: 8),
            Align(
                alignment: Alignment.bottomRight,
                child: BoxButton(
                    title: "Update",
                    onTap: () {
                      _updateAddressDetails();
                    }))
          ],
        ),
      ),
    );
  }

  // Recruitment Details Section
  Widget _buildRecruitmentDetailsSection(double width) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recruitment details', style: AppTextStyle.normalHeading),
          const SizedBox(height: 10),
          _buildRecruitmentDetailsBox(width),
        ],
      ),
    );
  }

// Recruitment Details Box
  Widget _buildRecruitmentDetailsBox(double width) {
    return Container(
      width: width * 0.4,
      height: 498,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.edit, color: textGrey),
          ),
          recruitDetailsWidget(width: width * 4),
        ],
      ),
    );
  }

  // Define the recruitDetailsWidget function properly
  Widget recruitDetailsWidget({required double width}) {
    return SizedBox(
      width: width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (postedJobTitle != null && postingDate != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(postedJobTitle!), // Display the posted job title
                Text(
                    'Job posting opened on $postingDate'), // Display posting date
                const Divider(),
              ],
            )
          else
            const Text(
                'No recruitment details available'), // Fallback if no job posted
        ],
      ),
    );
  }

  // Add Recruitment Section
  Widget AddRecruitmentSection(double width) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add a new Recruitment',
              style: AppTextStyle.normalHeading),
          const SizedBox(height: 10),
          _buildAddRecruitmentForm(width),
        ],
      ),
    );
  }

  // Add Recruitment Form
  Widget _buildAddRecruitmentForm(double width) {
    return Container(
      height: 498,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              _buildPositionField(),
              const SizedBox(height: 10),
              _textField(
                  textMaxlines: 3,
                  controller: jobSummaryController,
                  validator: validateRequired,
                  width: width * 0.3,
                  label: 'Job Summary'),
              _buildDropdown(
                  width: width * 0.3,
                  label: 'Experience',
                  value: selectedExperience,
                  items: experiences,
                  onChanged: (value) => setState(() {
                        selectedExperience = value;
                      })),
              _textField(
                  controller: jobLocationController,
                  validator: validateRequired,
                  width: width * 0.3,
                  label: 'Location'),
              // No of Vacancy Field with Numeric Input
              _numericField(
                  validator: numberValidator, // Pass the validator
                  controller: jobVacancyController,
                  width: width * 0.3,
                  label: 'No of Vacancy'),
              _buildDropdown(
                  width: width * 0.3,
                  label: 'Job Mode',
                  value: selectedJobMode,
                  items: jobModes,
                  onChanged: (value) => setState(() {
                        selectedJobMode = value;
                      })),

              // Salary Field with Numeric Input
              _numericField(
                  validator: numberValidator,
                  controller: salaryController,
                  width: width * 0.3,
                  label: 'Salary'),
              _buildDropdown(
                  width: width * 0.3,
                  label: 'Employment Type',
                  value: selectedEmploymentType,
                  items: employmentTypes,
                  onChanged: (value) => setState(() {
                        selectedEmploymentType = value;
                      })),
              _textField(
                  textMaxlines: 3,
                  controller: keyRespoController,
                  validator: validateRequired,
                  width: width * 0.3,
                  label: 'Key Responsibilities'),

              // Box for Requirements with Subcategories
              Container(
                width: width * 0.3,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Requirements',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Education Subcategory
                    _subCategoryField(
                        maxLines: 2,
                        controller: educationController,
                        validator: validateRequired,
                        hintText: 'Education'),

                    // Skills Subcategory
                    _subCategoryField(
                        controller: skillsController,
                        validator: validateRequired,
                        hintText: 'Skills',
                        maxLines: 2),

                    // Experience Subcategory
                    _subCategoryField(
                        validator: validateRequired,
                        maxLines: 2,
                        controller: requirementExperienceController,
                        hintText: 'Experience'),
                  ],
                ),
              ),

              /// post Button
              const SizedBox(height: 10),
              BoxButton(
                  title: 'Post Job',
                  onTap: () {
                    // Validate before calling createJob()
                    if (_formKey.currentState?.validate() ?? false) {
                      // If all fields are valid, call createJob()
                      createJob();
                    }
                  }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Position Field
  Widget _buildPositionField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 180,
            child: TextField(
              controller: jobTitleController,
              decoration: const InputDecoration(hintText: 'Position'),
            ),
          ),
        ),
      ],
    );
  }

  // Editable Row Widget for Details
  Widget _buildEditableRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.bodytext),
        const Icon(Icons.edit, color: textGrey, size: 15),
      ],
    );
  }

  // Editable TextField Widget
  Widget _buildEditableTextField({required String hint, required controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }

  // Generalized TextField Widget
  Widget _textField({
    required TextEditingController controller,
    String? Function(String? value)? validator,
    hint,
    int textMaxlines = 1,
    int hintMaxline = 1,
    required double width,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        child: TextFormField(
          maxLines: textMaxlines,
          keyboardType: TextInputType.number,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintMaxLines: hintMaxline,
            labelText: label,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10.0),
          ),
        ),
      ),
    );
  }

  // General Dropdown Widget
  Widget _buildDropdown({
    required double width,
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        child: DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Please select a $label' : null,
        ),
      ),
    );
  }

  // Subcategory TextField Widget (without border, label, with hint)
  Widget _subCategoryField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String? value)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none, // No border for subcategories
          contentPadding: const EdgeInsets.all(8.0), // Padding inside the field
        ),
      ),
    );
  }

  Widget _numericField({
    required TextEditingController controller,
    required double width,
    required String label,
    String? Function(String?)? validator, // Add validator parameter
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        child: TextFormField(
          controller: controller,
          validator: validator, // Use the validator for additional checks
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly // Allow only digits
          ],
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10.0),
          ),
        ),
      ),
    );
  }
}
