
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/AddShippingAddressService.dart';
import 'package:fonofy/Manage%20Address/ManageAddressScreen.dart';
import '../Api_Service/ShippingAddressService/LocationService.dart';
import '../TokenHelper/TokenHelper.dart';
import '../model/LocationModel/CityModel.dart';
import '../model/ShippingAddressModel/ListShippingAddressModel.dart';
import '../model/LocationModel/LocationModel.dart';
import '../widgets/TextField.dart';

class AddNewAddressScreen extends StatefulWidget {
  final String customerId;
  final ListShippingAddressModel? address;

  const AddNewAddressScreen({super.key, required this.customerId, required this.address});

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

  List<String> workTypes = ["Home", "Office", "Another"];
  String? selectedWorkType;


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    stateController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    addressController.dispose();
    workTypeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
    fetchLocationData();

    if (widget.address != null) {

      nameController.text = widget.address?.name ?? "";
      emailController.text = widget.address?.emailId ?? "";
      mobileController.text = widget.address?.mobileNo ?? "";
      pinCodeController.text = widget.address?.pinCode ?? "";
      addressController.text = widget.address?.address ?? "";

      selectedWorkType = widget.address?.workType;
      workTypeController.text = selectedWorkType ?? "";

      selectedState = widget.address?.state;
      stateController.text = selectedState ?? "";

      selectedCity = widget.address?.city;
      cityController.text = selectedCity ?? "";

      // fetchCityData(int.parse(selectedState!));
      print('City :- ${widget.address?.city}');

      // fetchCityData(int.parse(selectedState!));
      // print('City :- ${widget.address?.city}');

      // final selectedStateObj = locations.firstWhere(
      //       (loc) => loc.locationName == widget.address!.state,
      //   orElse: () => LocationModel(id: 0, locationName: ""),
      // );
      //
      // if (selectedStateObj.id != 0) {
      //   selectedState = selectedStateObj.id.toString();
      //   stateController.text = selectedStateObj.locationName;
      //
      //   // Fetch cities using then instead of await
      //   LocationService().fetchCities(selectedStateObj.id).then((fetchedCities) {
      //     setState(() {
      //       cityList = fetchedCities;
      //       final selectedCityObj = cityList.firstWhere(
      //             (city) => city.cityname == widget.address!.city,
      //         orElse: () => CityModel(id: 0, stateId: 0, cityname: ""),
      //       );
      //       if (selectedCityObj.id != 0) {
      //         selectedCity = selectedCityObj.id.toString(); // Use ID
      //         cityController.text = selectedCityObj.cityname;
      //       }
      //     });
      //   });
      // }
    }
  }
  Future<void> _initializeData() async {
    String? storedToken = await TokenHelper.getToken();
    String? user_Code = await TokenHelper.getUserCode();

    setState(() {
      token = storedToken ?? "";
      userCode = user_Code ?? "";
    });
    if (storedToken == null || storedToken.isEmpty) {
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
      print("❌ Error fetching locations: $e");
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
    } catch (e) {
      setState(() {
        isCityLoading = false;
      });
      print("❌ Error fetching cities: $e");
    }
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }
  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mobile Number is required";
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit mobile number";
    }
    return null;
  }
  String? validatePinCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "PIN Code is required";
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return "Enter a valid 6-digit PIN Code";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Address", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
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
          child: Column(
            children: [
              GlobalTextField(
              hint: 'Name *', controller: nameController,
              validator: (value) => validateRequired(value, "Name"),),

              GlobalTextField(
                  hint: 'Email *',
                  controller: emailController,
                validator: validateEmail,
              ),

              GlobalTextField(
                hint: 'Mobile Number *',
                controller: mobileController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                prefixText: '+91 ',
                prefixStyle: TextStyle(color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                validator: validateMobile,
              ),

              Container(
                margin: EdgeInsets.all(5),
                child: DropdownButtonFormField2<String>(
                  value: selectedState,
                  isExpanded: true,
                  hint: Text("Select State"),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  items: locations.map((state) {
                    return DropdownMenuItem<String>(
                      value: state.id.toString(),
                      child: Text(state.locationName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      stateController.text = newValue!;
                      selectedState = newValue;
                      selectedCity = null;
                      cityController.clear();
                    });
                    fetchCityData(int.parse(newValue!));
                  },
                  validator: (value) => value == null ? "State is required" : null,
                ),
              ),

              // Container(
              //   margin: EdgeInsets.all(5),
              //   child: DropdownButtonFormField2<String>(
              //     value: selectedCity,
              //     hint:  Text("$selectedCity"),
              //     // hint:  Text("$selectedCity Select City"),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //     ),
              //     items: cityList.map((city) {
              //       return DropdownMenuItem<String>(
              //         value: city.id.toString(),
              //         child: Text(city.cityname, overflow: TextOverflow.ellipsis),
              //       );
              //     }).toList(),
              //     onChanged: (newValue) {
              //       if (newValue != null) {
              //         setState(() {
              //           selectedCity = newValue;
              //           cityController.text = newValue;
              //         });
              //       }
              //     },
              //     validator: (value) => value == null ? "City is required" : null,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(5),
                child: DropdownButtonFormField2<String>(
                  value: selectedCity,
                  hint: Padding(
                    padding:  EdgeInsets.only(right: 10),
                    child: Text(
                      selectedCity ?? "Select City",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: cityList.map((city) {
                    return DropdownMenuItem<String>(
                      value: city.id.toString(),
                      child: Text(city.cityname, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedCity = newValue;
                        cityController.text = newValue;
                      });
                    }
                  },
                  validator: (value) => value == null ? "City is required" : null,
                ),
              ),


              GlobalTextField(hint: 'PIN Code *',
                  controller: pinCodeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                validator: validatePinCode),

              Container(
                margin: EdgeInsets.all(5),
                child: DropdownButtonFormField2<String>(
                  value: selectedWorkType,
                  hint: const Text("Select Work Type"),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  items: workTypes.map((workType) {
                    return DropdownMenuItem<String>(
                      value: workType,
                      child: Text(workType),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedWorkType = newValue;
                      workTypeController.text = newValue!;
                    });
                  },
                  validator: (value) => value == null ? "Work Type is required" : null,
                ),
              ),

              GlobalTextField(hint: 'Address *',
                  controller: addressController,
                  maxLine: 3,
                validator: (value) => validateRequired(value, "Address"),
              ),

              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await AddShippingAddressService().addShippingAddress(
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageAddressScreen(customerId: widget.customerId),));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Shipping address inserted successfully!"), backgroundColor: Colors.green));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to save address: $e"), backgroundColor: Colors.red));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Save", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
