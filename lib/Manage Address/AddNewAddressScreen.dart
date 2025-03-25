import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Colors.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
        backgroundColor: Colors.white, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Name *", "First name"),
              _buildTextField("Email *", "Email"),
              _buildTextField("Mobile Number *", "Phone number"),
              _buildTextField("State", "Select your state"),
              _buildTextField("City", "Select your city"),
              _buildTextField("PIN Code", "Pin Code"),
              _buildTextField("Work Type", "Home"),
              _buildTextField("Address *", "Address", maxLines: 3),

              const SizedBox(height: 20),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle save action
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:ColorConstants.appBlueColor3
                    ),
                    child: const Text("Save", style: TextStyle(fontSize: 16),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}
