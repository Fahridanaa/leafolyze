import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? _profileImage; // Menyimpan gambar profil

  @override
  void initState() {
    super.initState();
    nameController.text = "Petani User";
    birthController.text = "1990-05-15";
    genderController.text = "Perempuan";
    addressController.text = "Jalan Petani 5";
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        birthController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    genderController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage('assets/images/profile_placeholder.png')
                              as ImageProvider,
                    ),
                    TextButton(
                      onPressed: _pickImage,
                      child: Text(
                        'Edit picture or avatar',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildTextField("Name", nameController),
              buildTextField(
                "Birth",
                birthController,
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              buildTextField("Gender", genderController),
              buildTextField("Address", addressController),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final birth = birthController.text;
                    final gender = genderController.text;
                    final address = addressController.text;

                    print("Name: $name");
                    print("Birth: $birth");
                    print("Gender: $gender");
                    print("Address: $address");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data saved successfully!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text("SAVE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
