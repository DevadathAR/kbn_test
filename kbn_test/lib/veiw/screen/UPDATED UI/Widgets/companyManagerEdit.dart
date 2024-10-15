// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/text_style.dart';

// class EditableCompanyAndManager extends StatefulWidget {
//   final Function(String, String, String) onSave;

//   const EditableCompanyAndManager({required this.onSave, Key? key})
//       : super(key: key);

//   @override
//   _EditableCompanyAndManagerState createState() =>
//       _EditableCompanyAndManagerState();
// }

// class _EditableCompanyAndManagerState extends State<EditableCompanyAndManager> {
//   final TextEditingController _subController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   final ApiServices _apiService = ApiServices(); // API service instance

//   Uint8List? _selectedImage;
//   String? _imageFilename;

//   // Function to handle form submission
//   Future<void> _submitData() async {
//     // Validate the fields before sending data
//     if (_subController.text.isEmpty || _emailController.text.isEmpty) {
//       // You can display an error message if any field is empty
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields!')),
//       );
//       return;
//     }

//     try {
//       // Call the API service to send data to the server
//       var response = await _apiService.sendManagerData(
//         managerName: _subController.text,
//         email: _emailController.text,
//         selectedImage: _selectedImage,
//         imageFilename: _imageFilename, // Can be null if no image is selected

//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Data saved successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Failed to save data: ${response.statusCode}')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $error')),
//       );
//     }
//   }

//   Future<void> _selectImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _selectedImage = bytes;
//         _imageFilename = pickedFile.name; // Store the filename
//       });
//     } else {
//       setState(() {
//         _selectedImage = null;
//         _imageFilename = null; // Clear the filename
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Container(
//         width: size.width > 900 ? (size.width - 200) * .6 : null,
//         height: 250,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//           color: Colors.white,
//           border: Border.all(color: Colors.black),
//         ),
//         child: Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _selectImage();
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: const BorderRadius.all(Radius.circular(6)),
//                     color: Colors.transparent,
//                   ),
//                   child: _selectedImage != null
//                       ? CircleAvatar(
//                           backgroundImage: MemoryImage(_selectedImage!),
//                         )
//                       : Image.asset(personPng),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: size.width > 900 ? (size.width - 200) * .45 : null,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "${userDetails['user']['name']}",
//                       style: AppTextStyle.sixteen_w400_black,
//                     ),
//                   ),
//                   TextFormField(
//                     controller: _subController,
//                     decoration: const InputDecoration(
//                       labelText: "Manager Name",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _submitData(); // Call the function to submit data
//                         widget.onSave(
//                           "${userDetails['user']['name']}",
//                           _subController.text,
//                           _emailController.text,
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         side: const BorderSide(color: Colors.black),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         "Save",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
