// import 'package:flutter/material.dart';



// class RadioButtonExample extends StatefulWidget {
//   @override
//   _RadioButtonExampleState createState() => _RadioButtonExampleState();
// }

// class _RadioButtonExampleState extends State<RadioButtonExample> {
//   // Variable to hold the selected value
//   String _selectedOption = 'Option 1';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Radio Button Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Select an option:',
//               style: TextStyle(fontSize: 18),
//             ),
//             ListTile(
//               title: const Text('Option 1'),
//               leading: Radio<String>(
//                 value: 'Option 1',
//                 groupValue: _selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedOption = value!;
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text('Option 2'),
//               leading: Radio<String>(
//                 value: 'Option 2',
//                 groupValue: _selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedOption = value!;
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text('Option 3'),
//               leading: Radio<String>(
//                 value: 'Option 3',
//                 groupValue: _selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedOption = value!;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Selected: $_selectedOption',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
