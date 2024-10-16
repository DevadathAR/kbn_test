import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/commonTable.dart';

class CompanyJobpage extends StatefulWidget {
  const CompanyJobpage({super.key});

  @override
  State<CompanyJobpage> createState() => _CompanyJobpageState();
}

class _CompanyJobpageState extends State<CompanyJobpage> {
  CompanyApiResponse? _companyData; // Holds the company data
  bool _isLoading = true; // Controls the loading state
  bool _hasError = false; // Controls the error state

  @override
  void initState() {
    super.initState();
    _fetchCompanyData();
  }

  void _fetchCompanyData() async {
    try {
      CompanyApiResponse data = await ApiServices.companyData();
      setState(() {
        _companyData = data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Map<String, String>> jobTableHeaders = [
      {'header': 'Designation', 'key': 'designation'},
      {'header': 'Experience', 'key': 'experience'},
      {'header': 'Location', 'key': 'location'},
      {'header': 'Vaccancy', 'key': 'vacancy'},
      {'header': 'Selected applicants', 'key': 'selected'},
      {'header': 'Employment type', 'key': 'jobType'},
      {'header': 'Salary', 'key': 'salary'},
      {'header': 'Status', 'key': 'status'},
    ];

    return ScaffoldBuilder(
      onMonthSelection: () {
        setState(() {
          _isLoading = true;
        });
        _fetchCompanyData(); // Re-fetch company data
      },
      currentPath: "Jobs",
      pageName: "Jobs",
      child: SizedBox(
        height: 550,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            // : _hasError
            //     ? const Center(child: Text("Error loading job data"))
            : _buildContent(size, jobTableHeaders),
      ),
    );
  }

  Widget _buildContent(Size size, List<Map<String, String>> headers) {
    // Map the company data to the jobTableData
    List<Map<String, String>>? jobTableData =
        _companyData?.companyData.jobsPageData.map((job) {
      return {
        'id': job.jobId.toString(),
        'designation': job.designation,
        'experience': job.experience,
        'location': job.location.toString().split('.').last,
        'vacancy': job.vacancy.toString(),
        'selected': job.selected.toString(),
        'jobType': job.jobType.toUpperCase(),
        'salary': 'Rs. ${job.salary}',
        'status': job.status,
      };
    }).toList();

    return ListView(
      children: [
        Wrap(
          spacing: 10,
          children: [
            Expanded(
              child: jobDataTable(
                context: context,
                headers: headers,
                data: jobTableData,
                onStatusChange: (int applicationId, String newStatus) {
                  setState(() {
                    jobTableData = jobTableData?.map((job) {
                      if (int.parse(job['id']!) == applicationId) {
                        job['status'] =
                            newStatus; // Update the status for the selected row
                      }
                      return job;
                    }).toList();
                  });
                },
              ),
            ),
            if (size.width < 1200) const SizedBox(height: 5),
            // jobCreationForm
            const jobDetailsForm(),
          ],
        )
      ],
    );
  }
}

Widget jobDataTable({
  required BuildContext context,
  required List<Map<String, String>> headers,
  required List<Map<String, String>>? data,
  required Function(int applicationId, String newStatus) onStatusChange,
}) {
  Size size = MediaQuery.of(context).size;

  // Check if data is null or empty, and if so, provide default empty rows
  data ??= List.generate(
    6, // Display 6 empty rows
    (_) => {
      'designation': 'Not Available',
      'experience': 'Not Available',
      'location': 'Not Available',
      'vacancy': '0',
      'selected': '0',
      'jobType': 'Not Available',
      'salary': '0',
      'status': 'Not Available',
    },
  );

  return Container(
    width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
    height: 400,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      children: [
        // Header row
        Table(
          border: tableHeaderDec(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: _generateColumnWidths(headers.length),
          children: [
            TableRow(
              children: headers.map((header) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.5,
                    horizontal: 5.0,
                  ),
                  child: Text(
                    header['header']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        // Data rows
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
                verticalInside: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
              columnWidths: _generateColumnWidths(headers.length),
              children: [
                ...data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final row = entry.value;
                  return TableRow(
                    children: headers.map((header) {
                      if (header['key'] == 'status') {
                        return CustomJobStatus(
                          status: row['status'] ?? 'Not Available',
                          applicationId: int.tryParse(row['id'] ?? '0') ?? 0,
                          onStatusChange: (updatedStatus) {
                            onStatusChange(int.tryParse(row['id'] ?? '0') ?? 0,
                                updatedStatus);
                          },
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 23.5,
                            horizontal: 5.0,
                          ),
                          child: Text(
                            row[header['key']] ?? 'Not Available',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.normalText,
                          ),
                        );
                      }
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget jobDataTable({
//   context,
//   required List<Map<String, String>> headers,
//   required List<Map<String, String>> Data,
//   required Function(int applicationId, String newStatus)
//       onStatusChange, // Modify the callback to pass status
// }) {
//   Size size = MediaQuery.of(context).size;

//   return Container(
//     width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
//     height: 400,
//     padding: const EdgeInsets.all(16.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//       color: Colors.white,
//     ),
//     child: Column(
//       children: [
//         // Header row
//         Table(
//           border: tableHeaderDec(),
//           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//           columnWidths: _generateColumnWidths(headers.length),
//           children: [
//             TableRow(
//               children: headers.map((header) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 18.5,
//                     horizontal: 5.0,
//                   ),
//                   child: Text(
//                     header['header']!,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//         // Data rows
//         Expanded(
//           child: SingleChildScrollView(
//             child: Table(
//               defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//               border: TableBorder(
//                 horizontalInside: BorderSide(
//                   color: Colors.grey.withOpacity(0.5),
//                   width: 0.5,
//                 ),
//                 verticalInside: BorderSide(
//                   color: Colors.grey.withOpacity(0.5),
//                   width: 0.5,
//                 ),
//               ),
//               columnWidths: _generateColumnWidths(headers.length),
//               children: [
//                 ...Data.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final row = entry.value;
//                   return TableRow(
//                     children: headers.map((header) {
//                       if (header['key'] == 'status') {
//                         return CustomJobStatus(
//                           status: row['status'] ??
//                               '', // Pass the row-specific status
//                           applicationId: int.tryParse(row['id'] ?? '0') ?? 0,
//                           onStatusChange: (updatedStatus) {
//                             onStatusChange(int.tryParse(row['id'] ?? '0') ?? 0,
//                                 updatedStatus);
//                           },
//                         );
//                       } else {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 23.5,
//                             horizontal: 5.0,
//                           ),
//                           child: Text(
//                             row[header['key']] ?? '',
//                             textAlign: TextAlign.center,
//                             style: AppTextStyle.normalText,
//                           ),
//                         );
//                       }
//                     }).toList(),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

/// Helper function to generate column widths based on the number of headers
Map<int, TableColumnWidth> _generateColumnWidths(int headerCount) {
  Map<int, TableColumnWidth> columnWidths = {};
  for (int i = 0; i < headerCount; i++) {
    columnWidths[i] =
        const FlexColumnWidth(); // Adjustable width for each column
  }
  return columnWidths;
}

class CustomJobStatus extends StatefulWidget {
  final String? path;
  final String status;
  final int applicationId;
  final Function(String newStatus) onStatusChange; // Updated callback signature

  const CustomJobStatus({
    super.key,
    required this.status,
    required this.applicationId,
    required this.onStatusChange,
    this.path,
  });

  @override
  _CustomJobStatusState createState() => _CustomJobStatusState();
}

class _CustomJobStatusState extends State<CustomJobStatus> {
  String status = '';

  @override
  void initState() {
    super.initState();
    status = widget.status; // Initialize the status with the passed value
  }

  void _setStatus(String newStatus) async {
    setState(() {
      status = newStatus;
    });
    // Proceed with the API call
    try {
      await ApiServices.updateJobStatus(status, widget.applicationId);
      widget.onStatusChange(newStatus); // Call the callback with the new status
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status == "Closed") {
      return const Text(
        "Closed",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        _setStatus("Closed");
      },
      child: Container(
        width: 80,
        height: 15, // Button height
        alignment: Alignment.center, // Center align the text
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: const Text(
          "Close",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: tealblue,
          ),
        ),
      ),
    );
  }
}

class jobDetailsForm extends StatefulWidget {
  const jobDetailsForm({super.key});

  @override
  State<jobDetailsForm> createState() => _jobDetailsFormState();
}

class _jobDetailsFormState extends State<jobDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 500,
      // padding: const EdgeInsets.only(bottom: 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)), color: white),
      width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: (size.width - 200) * .32,
                      child: TextFormField(
                        controller: jobTitleController,
                        decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Position",
                            hintStyle: AppTextStyle.normalText),
                      )),
                  const Icon(Icons.edit)
                ],
              ),
            ),
            _textField(
                textMaxlines: 3,
                controller: jobSummaryController,
                validator: validateRequired,
                // width: 680,
                width: size.width > 1200
                    ? (size.width - 200) * 0.455
                    : size.width > 900
                        ? (size.width - 200) * 0.7
                        : (size.width) * 0.775,
                hight: 60,
                label: 'Job Summary'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _textField(
                    textMaxlines: 1,
                    controller: jobLocationController,
                    validator: validateRequired,
                    width: size.width > 1200
                        ? size.width * 0.19
                        : size.width > 900
                            ? (size.width) * 0.22
                            : size.width * 0.33,
                    label: 'Location'),
                _buildDropdown(
                    width: size.width > 1200
                        ? size.width * 0.19
                        : size.width > 900
                            ? (size.width) * 0.22
                            : size.width * 0.33,
                    label: 'Experience',
                    value: selectedExperience,
                    items: experiences,
                    onChanged: (value) => setState(() {
                          selectedExperience = value;
                        })),
              ],
            ),
            // vaccancy and jobMode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _numericField(
                    validator: numberValidator,
                    controller: jobVacancyController,
                    width: size.width > 1200
                        ? size.width * 0.19
                        : size.width > 900
                            ? (size.width) * 0.22
                            : size.width * 0.33,
                    label: 'Vaccancy'),
                _buildDropdown(
                    width: size.width > 1200
                        ? size.width * 0.19
                        : size.width > 900
                            ? (size.width) * 0.22
                            : size.width * 0.33,
                    label: 'Job Mode',
                    value: selectedJobMode,
                    items: jobModes,
                    onChanged: (value) => setState(() {
                          selectedJobMode = value;
                        })),
              ],
            ),
            // salary and Employment Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _numericField(
                    validator: numberValidator,
                    controller: salaryController,
                    width: size.width > 1200
                        ? size.width * 0.19
                        : size.width > 900
                            ? (size.width) * 0.22
                            : size.width * 0.33,
                    label: 'Salary'),
                _buildDropdown(
                    width: size.width > 1200
                        ? size.width * 0.19
                        : size.width > 900
                            ? (size.width) * 0.22
                            : size.width * 0.33,
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
                width: size.width > 1200
                    ? (size.width - 200) * 0.455
                    : size.width > 900
                        ? (size.width - 200) * 0.7
                        : (size.width) * 0.775,
                // width: 680,
                hight: 60,
                label: 'Key Responsibilities'),

            // requimnts
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width > 1200
                      ? 25
                      : size.width > 900
                          ? (size.width - 200) * 0.15
                          : (size.width) * 0.11,
                  vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      // width: 575,
                      // width: (size.width - 200) * .32,
                      width: size.width > 1200
                          ? (size.width - 200) * 0.32
                          : size.width > 900
                              ? (size.width - 200) * 0.5
                              : (size.width - 100) * 0.5,

                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Requirements',
                              style: AppTextStyle.normalText
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 1),

                          // Education Subcategory
                          _subCategoryField(
                              maxLines: 1,
                              controller: educationController,
                              validator: validateRequired,
                              hintText: 'Education'),

                          // Skills Subcategory
                          _subCategoryField(
                              controller: skillsController,
                              validator: validateRequired,
                              hintText: 'Skills',
                              maxLines: 1),

                          // Experience Subcategory
                          _subCategoryField(
                              validator: validateRequired,
                              maxLines: 1,
                              controller: requirementExperienceController,
                              hintText: 'Experience'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: tealblue),
                    width: 100,
                    child: TextButton(
                        onPressed: () {
                          // Validate before calling createJob()
                          if (_formKey.currentState?.validate() ?? false) {
                            // If all fields are valid, call createJob()
                            createJob();
                          }
                        },
                        child: const Text(
                          "CREATE",
                          style: AppTextStyle.fifteenW500,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
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

// // Generalized TextField Widget
  Widget _textField(
      {required TextEditingController controller,
      String? Function(String? value)? validator,
      hint,
      int textMaxlines = 1,
      int hintMaxline = 1,
      required double width,
      required String label,
      double hight = 40}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        height: hight,
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
            labelStyle: AppTextStyle.normalText,
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
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        height: 40,
        width: width,
        child: DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTextStyle.normalText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTextStyle.normalText,
              ),
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
      padding: const EdgeInsets.only(bottom: 3.0),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.normalText,

            border: InputBorder.none, // No border for subcategories
            contentPadding:
                const EdgeInsets.all(2.0), // Padding inside the field
          ),
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
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        height: 40,
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
            labelStyle: AppTextStyle.normalText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10.0),
          ),
        ),
      ),
    );
  }
}
