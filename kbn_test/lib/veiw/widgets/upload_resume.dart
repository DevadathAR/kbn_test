import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/user_screen/home.dart';

class UploadMyResume extends StatefulWidget {
  const UploadMyResume({super.key});

  @override
  State<UploadMyResume> createState() => _UploadMyResumeState();
}

class _UploadMyResumeState extends State<UploadMyResume> {
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;
  String? _fileExtension;

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFileBytes = result.files.first.bytes;
        _selectedFileName = result.files.first.name;
        _fileExtension = result.files.first.extension;
      });

      // Send file to the API
      _uploadFileToAPI(_selectedFileBytes!, _selectedFileName!);

      // Navigate to Home after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
      });
    } else {
      setState(() {
        _selectedFileBytes = null;
        _selectedFileName = null;
        _fileExtension = null;
      });
    }
  }

  Future<void> _uploadFileToAPI(Uint8List fileBytes, String fileName) async {
    try {
      final uri = Uri.parse('http://192.168.29.37:8000/user/resume'); // Replace with your API endpoint
      final request = http.MultipartRequest('POST', uri)
        ..files.add(
          http.MultipartFile.fromBytes(
            'resume', // The name of the field on the server
            fileBytes,
            filename: fileName,
          ),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle success
        print("File uploaded successfully!");
      } else {
        // Handle error
        print("File upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exception
      print("File upload failed with exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: semitransp,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _selectFile();
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 250,
              width: 225,
              child: _selectedFileBytes != null
                  ? _fileExtension == "jpg" || _fileExtension == "png"
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(_selectedFileBytes!),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.insert_drive_file, size: 50),
                            Text(
                              _selectedFileName ?? "Selected file",
                              style: AppTextStyle.abouttxt,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                  : Image.asset(resumePng),
            ),
          ),
        ),
      ],
    );
  }
}
