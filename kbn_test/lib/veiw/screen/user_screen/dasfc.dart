// import 'package:http/http.dart' as http;

// void _signup() async {
//   // Get the input from the text fields
//   String fullName = fullNameController.text;
//   String userName = userNameController.text;
//   String password = passwordController.text;
//   String confirmPassword = confirmPasswordController.text;
//   String contactNumber = contactNumController.text;

//   // Check if the passwords match
//   if (password != confirmPassword) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Passwords do not match')),
//     );
//     return;
//   }

//   // Create a new user account
//   final url = Uri.parse('https://example.com/signup');
//   final headers = {
//     'Content-Type': 'application/json',
//   };
//   final body = jsonEncode({
//     'full_name': fullName,
//     'username': userName,
//     'password': password,
//     'contact_number': contactNumber,
//     'image': _selectedImage != null ? base64Encode(_selectedImage!) : null,
//   });

//   final response = await http.post(url, headers: headers, body: body);

//   if (response.statusCode == 201) {
//     // Account created successfully
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const Home(),
//       ),
//     );
//   } else {
//     // Error creating account
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Error creating account')),
//     );
//   }
// }