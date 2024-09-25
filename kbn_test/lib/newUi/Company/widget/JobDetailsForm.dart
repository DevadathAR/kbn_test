import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';

class jobDetailsForm extends StatefulWidget {
  const jobDetailsForm({super.key});

  @override
  State<jobDetailsForm> createState() => _jobDetailsFormState();
}

class _jobDetailsFormState extends State<jobDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final TextEditingController addressTextController = TextEditingController();
  // final TextEditingController mailIdController = TextEditingController();
  // final TextEditingController contactController = TextEditingController();
  // final TextEditingController websiteController = TextEditingController();
  // final TextEditingController businessTypeController = TextEditingController();

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
  bool isApproved = false;

  final List<String> employmentTypes = ['Full-Time', 'Part-Time', 'Contract'];
  final List<String> jobModes = ['On-site', 'Remote', 'Hybrid'];
  final List<String> experiences = [
    'Fresher ,0-2 years',
    'Junior level, 2-5 years',
    'Senior level, 5+ years'
  ];

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
        // var jobResponse = jsonDecode(response.body);

        setState(() {
          // Clear all text fields
          jobTitleController.clear();
          jobSummaryController.clear();
          jobLocationController.clear();
          jobVacancyController.clear();
          salaryController.clear();
          keyRespoController.clear();
          educationController.clear();
          skillsController.clear();
          requirementExperienceController.clear();

          // Reset dropdowns
          selectedExperience = null;
          selectedJobMode = null;
          selectedEmploymentType = null;
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

  Future<void> fetchUserData() async {
    try {
      var userData = await ApiServices.fetchUserDetails();
      setState(() {
        userDetails = userData;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred while fetching user data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)), color: white),
// width:700,
      width: null,
      //  width:   size.width-920,      // height: 700,
      child: Column(
        children: [
          const Text("Position"),
          _textField(
              textMaxlines: 3,
              controller: jobSummaryController,
              validator: validateRequired,
              width: 680,
              label: 'Job Summary'),
          Wrap(
            children: [
              _textField(
                  textMaxlines: 1,
                  controller: jobLocationController,
                  validator: validateRequired,
                  width: 310,
                  label: 'Location'),
              _buildDropdown(
                  width: 350,
                  label: 'Experience',
                  value: selectedExperience,
                  items: experiences,
                  onChanged: (value) => setState(() {
                        selectedExperience = value;
                      })),
            ],
          ),
          Wrap(
            children: [
              _textField(
                  textMaxlines: 1,
                  controller: jobVacancyController,
                  validator: validateRequired,
                  width: 310,
                  label: 'Vacancy'),
              _buildDropdown(
                  width: 350,
                  label: 'Job Mode',
                  value: selectedJobMode,
                  items: jobModes,
                  onChanged: (value) => setState(() {
                        selectedJobMode = value;
                      })),
            ],
          ),
          Wrap(
            children: [
              _textField(
                  textMaxlines: 1,
                  controller: salaryController,
                  validator: validateRequired,
                  width: 310,
                  label: 'Salary'),
              _buildDropdown(
                  width: 350,
                  label: 'Employment Type',
                  value: selectedEmploymentType,
                  items: employmentTypes,
                  onChanged: (value) => setState(() {
                        selectedEmploymentType = value;
                      })),
            ],
          ),
          _textField(
              textMaxlines: 3,
              controller: keyRespoController,
              validator: validateRequired,
              width: 680,
              label: 'Key Responsibilities'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: 680,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: tealblue),
              width: 100,
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "CREATE",
                    style: AppTextStyle.buttontxt,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget jobForm({numb = 1, text}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        maxLines: numb,
        decoration: InputDecoration(
            label: Text(text),
            border:
                const OutlineInputBorder(borderSide: BorderSide(color: black))),
      ),
    );
  }
  // Widget _buildEditableRow(String label) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(label, style: AppTextStyle.bodytext),
  //       const Icon(Icons.edit, color: textGrey, size: 15),
  //     ],
  //   );
  // }

// // Editable TextField Widget
//   Widget _buildEditableTextField({required String hint, required controller}) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hint,
//         border: InputBorder.none,
//         isDense: true,
//         contentPadding: const EdgeInsets.all(10),
//       ),
//     );
//   }

// // Generalized TextField Widget
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

// // General Dropdown Widget
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

  // Widget _numericField({
  //   required TextEditingController controller,
  //   required double width,
  //   required String label,
  //   String? Function(String?)? validator, // Add validator parameter
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SizedBox(
  //       width: width,
  //       child: TextFormField(
  //         controller: controller,
  //         validator: validator, // Use the validator for additional checks
  //         keyboardType: TextInputType.number,
  //         inputFormatters: <TextInputFormatter>[
  //           FilteringTextInputFormatter.digitsOnly // Allow only digits
  //         ],
  //         decoration: InputDecoration(
  //           labelText: label,
  //           border: const OutlineInputBorder(),
  //           contentPadding: const EdgeInsets.all(10.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
