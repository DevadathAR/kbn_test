import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/text_style.dart';

class EditableCompanyDetails extends StatefulWidget {
  final Function(String, String, String) onSave;

  const EditableCompanyDetails({required this.onSave, Key? key}) : super(key: key);

  @override
  _EditableCompanyDetailsState createState() => _EditableCompanyDetailsState();
}

class _EditableCompanyDetailsState extends State<EditableCompanyDetails> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _numbController = TextEditingController();
  bool _isLoading = false; // State to manage loading indicator

  // Function to handle form submission
  Future<void> _submitCompanyData() async {
    // Validate the fields before sending data
    if (_addressController.text.isEmpty ||
        _siteController.text.isEmpty ||
        _numbController.text.isEmpty) {
      // Display error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Call the API service to send data to the server
      var response = await ApiServices.sendUpdatedCompanyData(
        _addressController.text, // Address
        _numbController.text,    // Number
        _siteController.text,    // Website
      );

      if (response != null && response['message'] == 'Updated') {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saved successfully!')),
        );

        // Invoke the `onSave` callback to notify the parent
        // widget.onSave(
        //   _addressController.text,
        //   _siteController.text,
        //   _numbController.text,
        // );
      } else {
        // Show failure message with more detailed error information
        String errorMessage = response['message'] ?? 'Failed to save data.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $errorMessage')),
        );
      }
    } catch (error) {
      // Show error message when an exception occurs
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator after operation is complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(

          width: size.width > 900 ? (size.width - 225) * 0.4 : null,
          height: 455,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Add some padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Company Details",
                  style: AppTextStyle.sixteen_w400_black,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 8), // Add space between fields
                TextFormField(
                  controller: _numbController,
                  decoration: const InputDecoration(
                    labelText: "Number",
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 8), // Add space between fields
                TextFormField(
                  controller: _siteController,
                  decoration: const InputDecoration(
                    labelText: "Website",
                    border: InputBorder.none,
                  ),
                ),
                const Spacer(), // Push the button to the bottom
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null // Disable the button when loading
                        : () async {
                            await _submitCompanyData();
                            // Only call onSave if the data is successfully saved
                            if (!_isLoading) {
                              widget.onSave(
                                _addressController.text,
                                _siteController.text,
                                _numbController.text,
                              ); // Await function call
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
