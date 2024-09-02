import 'package:http/http.dart' as http;
import 'dart:convert';

void sendData() async {
  var url = Uri.parse('http://192.168.29.37:8000/api/data'); // Replace with the server PC's IP address
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "firstName": "john",
      "lastName": "wick",
      "dob": "2000-10-23",
      "gender": "M",
      "contact": "123456789",
      "address": "a34 twn down street new york us",
      "education": [
        {
          "qualification": "btech",
          "institute": "XYZ University",
          "year": 2021,
          "percentage": 90.25,
          "state": "kerala"
        },
        // Add more education objects as needed
      ],
      "skills": "fast-learner,kind,smart",
      "experience": [
        {
          "company": "google",
          "year": 2021,
          "position": "SDE",
          "state": "kerala",
          "description": "skdfjsdlkfjm"
        },
        // Add more experience objects as needed
      ],
      "email": "johnwick@gmail.com",
      "password": "john@123"
    }),
  );

  if (response.statusCode == 200) {
    print('Data sent successfully!');
  } else {
    print('Failed to send data.');
  }
  
}