import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/AddShippingAddressService.dart';
 import '../Api_Service/LocationService.dart';
import '../TokenHelper/TokenHelper.dart';
import '../model/CityModel.dart';
import '../model/LocationModel.dart';
import '../widgets/TextField.dart';

class AddNewAddressScreen extends StatefulWidget {
  final String customerId;
  const AddNewAddressScreen({super.key, required this.customerId});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final workTypeController = TextEditingController();

  String? selectedState;
  String? selectedCity;
  List<LocationModel> locations = [];
  List<CityModel> cityList = [];
  bool isLoading = true;
  bool isCityLoading = false;

  String token = "";
  String userCode = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    stateController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    workTypeController.dispose();
    addressController.dispose();
    workTypeController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _initializeData();
    fetchLocationData();
  }

  Future<void> _initializeData() async {
    String? storedToken = await TokenHelper.getToken();

    if (storedToken != null && storedToken.isNotEmpty) {
      String? user_Code = await TokenHelper.getUserCode();
      setState(() {
        token = storedToken;
        userCode = user_Code!;
      });
    } else {
      print("⚠️ Token is missing. Please log in again.");
    }
  }

  Future<void> fetchLocationData() async {
    try {
      List<LocationModel> fetchedLocations = await LocationService().fetchLocations();
      setState(() {
        locations = fetchedLocations;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching locations: $e");
    }
  }

  Future<void> fetchCityData(int stateId) async {
    setState(() {
      isCityLoading = true;
      cityList = [];
      selectedCity = null;
      cityController.clear();
    });

    try {
      List<CityModel> fetchedCities = await LocationService().fetchCities(stateId);
      setState(() {
        cityList = fetchedCities;
        isCityLoading = false;
      });
      print("✅ City List Updated: ${cityList.map((city) => city.cityname).toList()}"); // Debug log
    } catch (e) {
      setState(() {
        isCityLoading = false;
      });
      print("❌ Error Fetching Cities: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Address",style: TextStyle(color: Colors.white),
      ), backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                // GlobalTextField(hint: 'Name *', controller: nameController),
                GlobalTextField(
                  hint: 'Name *',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                // GlobalTextField(hint: 'Email *', controller: emailController),
                GlobalTextField(
                  hint: 'Email *',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                // GlobalTextField(hint: 'Mobile Number *', controller: mobileController),
                GlobalTextField(
                  hint: 'Mobile Number *',
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number is required';
                    } else if (value.length != 10) {
                      return 'Mobile number must be exactly 10 digits';
                    }
                    return null;
                  },
                ),

                //State Dropdown with Controller
                Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: DropdownButtonFormField2<String>(
                    value: selectedState,
                    hint: Text("Select State"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    ),
                    items: locations.map((LocationModel state) {
                      return DropdownMenuItem<String>(
                        value: state.id.toString(),
                        child: Text(state.locationName),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedState = newValue;
                        stateController.text = locations.firstWhere((state) => state.id.toString() == newValue).id.toString();
                        selectedCity = null;
                        cityController.clear();
                      });
                      int stateId = int.parse(newValue!);
                      fetchCityData(stateId);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a state';
                      }
                      return null;
                    },
                  ),
                ),

                //City Dropdown
                Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: DropdownButtonFormField2<String>(
                    value: selectedCity,
                    hint: const Text("Select City"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    ),
                    items: cityList.map((CityModel city) {
                      return DropdownMenuItem<String>(
                        child: Text(city.cityname),
                        value: city.id.toString(),

                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue;
                        cityController.text = cityList
                            .firstWhere((city) => city.id.toString() == newValue)
                            .id.toString();
                      });

                      // Print Selected City ID
                      print("Selected City ID: $selectedCity");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                  ),
                ),
                // GlobalTextField(hint: 'PIN Code *', controller: pinCodeController),
                GlobalTextField(
                  hint: 'PIN Code *',
                  controller: pinCodeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PIN Code is required';
                    } else if (value.length != 6) {
                      return 'PIN Code must be exactly 6 digits';
                    }
                    return null;
                  },
                ),
                GlobalTextField(hint: 'Work Type *',
                  controller: workTypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Work type is required';
                    }
                    return null;
                  },

                ),
                // GlobalTextField(hint: 'Address *', controller: addressController, maxLine: 3),
                GlobalTextField(
                  hint: 'Address *',
                  controller: addressController,
                  maxLine: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            AddShippingAddressService().addShippingAddress(
                              name: nameController.text,
                              emailId: emailController.text,
                              mobileNo: mobileController.text,
                              state: stateController.text,
                              city: cityController.text,
                              pinCode: pinCodeController.text,
                              workType: workTypeController.text,
                              address: addressController.text,
                              token: token,
                              userCode: widget.customerId,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("shipping address insert successfully.!"),
                                backgroundColor: Colors.green,
                              ),
                            );

                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed to save address: $e"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text("Save",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
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