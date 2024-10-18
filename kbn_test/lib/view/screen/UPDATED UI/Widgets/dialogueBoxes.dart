import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Widgets/warningDialogue.dart';
import 'package:kbn_test/view/widgets_common/boldText.dart';
import 'package:kbn_test/view/widgets_common/boxBTN.dart';
import 'package:kbn_test/view/widgets_common/normalText.dart';

import 'package:flutter/material.dart';

void showCompanyProfileDialog({
  required BuildContext context,
  required int companyId,
  required VoidCallback onApproval,
}) {
  showDialog(
    context: context,
    barrierColor: semitransp,
    builder: (context) {
      return CompanyProfileDialog(
        onApproval: onApproval,
        companyId: companyId,
      );
    },
  );
}

void showApplicantProfile({
  required BuildContext context,
  required int applicantId,
  required String designation,
}) {
  showDialog(
    context: context,
    barrierColor: semitransp,
    builder: (BuildContext context) {
      return ApplicantProfileDialog(
        applicantId: applicantId,
        designation: '',
      );
    },
  );
}

// void showProfileDialog({
//   required BuildContext context,
//   required bool isCompanyProfile, // true for company, false for applicant
//   String? name,
//   String? designation,
//   String? phoneNumber,
//   String? companyName,
//   String? companyWebsite,
//   String? profileImage,
//   String? aboutCompany,
//   VoidCallback? onResumeTap,
//   VoidCallback? onContactTap,
//   int? companyId,
//   bool isLoading = false,
// }) {
//   showDialog(
//     context: context,
//     barrierColor: semitransp, // Assuming this is a predefined variable
//     builder: (context) {
//       if (isCompanyProfile) {
//         return CompanyProfileDialog(
//           companyId: companyId ?? 0, // Provide a default companyId if null
//           profileImage: profileImage ?? '',
//           aboutCompany: aboutCompany ?? '',
//           companyName: companyName ?? '',
//           companyWebsite: companyWebsite ?? '',
//           isLoading: isLoading,
//         );
//       } else {
//         return ApplicantProfileDialog(
//           name: name ?? 'Unknown',
//           designation: designation ?? 'Unknown',
//           phoneNumber: phoneNumber ?? 'Unknown',
//           profileImage: profileImage ?? '',
//           onResumeTap: onResumeTap ?? () {},
//           onContactTap: onContactTap ?? () {},
//         );
//       }
//     },
//   );
// }

class ApplicantProfileDialog extends StatefulWidget {
  final int applicantId;
  final String designation;
  const ApplicantProfileDialog({
    super.key,
    required this.applicantId,
    required this.designation,
  });

  @override
  State<ApplicantProfileDialog> createState() => _ApplicantProfileDialogState();
}

class _ApplicantProfileDialogState extends State<ApplicantProfileDialog> {
  Map<String, dynamic> applicantDetails = {};
  bool isApproving = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var response =
          await ApiServices.fetchApplicantDetails(widget.applicantId);
      print(response);
      setState(() {
        applicantDetails = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 400,
        height: 248,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProfileImage(),
              const SizedBox(width: 10),
              _buildApplicantDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 202.82,
      height: 202.82,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: applicantDetails['user']['profile_image'] != null
              ? NetworkImage(
                  "${ApiServices.baseUrl}/${applicantDetails['user']['profile_image']}")
              : const AssetImage(compnyLogo) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildApplicantDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(
            text: applicantDetails['user']['name'] ?? 'No Data', size: 15.0),
        const SizedBox(height: 5),
        boldText(text: widget.designation, size: 15.0),
        const SizedBox(height: 5.0),
        normalText(text: applicantDetails['user']['contact'] ?? 'N/A'),
        const Spacer(),
        _buildActionButton('RESUME', () {}),
        const SizedBox(height: 5),
        _buildActionButton('CONTACT VIA MAIL', () {}, color: tealblue),
      ],
    );
  }

  Widget _buildActionButton(String text, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 118.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? Colors.black12,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// Assuming you have a file where colors and styles are defined

class CompanyProfileDialog extends StatefulWidget {
  final VoidCallback onApproval;

  final int companyId;

  const CompanyProfileDialog({
    super.key,
    required this.companyId,
    required this.onApproval,
  });

  @override
  _CompanyProfileDialogState createState() => _CompanyProfileDialogState();
}

class _CompanyProfileDialogState extends State<CompanyProfileDialog> {
  // CompanyApiResponse? companyData;\
  Map<String, dynamic> companyDetails = {};
  bool isApproving = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var response = await ApiServices.fetchApplicantDetails(widget.companyId);
      print(response);
      setState(() {
        companyDetails = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 516,
        height: 373,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildProfileImage(),
                  const SizedBox(width: 20),
                  _buildCompanySummary(),
                ],
              ),
              const SizedBox(height: 10),
              _buildCompanyDetails(),
              const SizedBox(height: 25),
              _buildApproveButton(widget.onApproval),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: companyDetails['user']['profile_image'] != null
              ? NetworkImage(
                  "${ApiServices.baseUrl}/${companyDetails['user']['profile_image']}")
              : const AssetImage(compnyLogo) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCompanySummary() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          boldText(text: "About Company", size: 16.0),
          normalText(
            text: companyDetails['user']['about_company'] ?? "N/A",
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyDetails() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: companyDetails['user']['name'] ?? "N/A", size: 15.0),
            const SizedBox(height: 5),
            boldText(
                text: companyDetails['user']['companyWebsite'] ?? "N/A",
                size: 15.0),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildApproveButton(VoidCallback onApproval) {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () async {
            approveCompany(onApproval);

            // await showDialog(
            //   context: context,
            //   builder: (context) {
            //     return WarningDialog(
            //         title: "Confirm Approval",
            //         content: 'Are you sure you want to approve this company?',
            //         onConfirm: () {
            //           approveCompany(onApproval);
            //         });
            //   },
            // );
          },
          child: Container(
            width: 105,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: tealblue,
            ),
            child: const Center(
              child: Text(
                'APPROVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void approveCompany(VoidCallback onApproval) async {
    setState(() => isApproving = true);

    try {
      await ApiServices.approveCompany(widget.companyId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Company approved successfully!')),
      );
      onApproval();
      Navigator.of(context).pop(); // Dismiss the dialog after success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve company: $e')),
      );
    } finally {
      setState(() => isApproving = false);
    }
  }
}
