import 'package:flutter/material.dart';

class CityDropdownWidget extends StatelessWidget {
  final String? selectedCity;
  final ValueChanged<String?> onCityChanged;
  final String? Function(String?)? validator;

  CityDropdownWidget(
      {super.key,
      this.selectedCity,
      required this.onCityChanged,
      this.validator});

  final List<String> cities = [
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Hyderabad",
    "Ahmedabad",
    "Chennai",
    "Kolkata",
    "Surat",
    "Pune",
    "Jaipur",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Indore",
    "Thane",
    "Bhopal",
    "Visakhapatnam",
    "Pimpri-Chinchwad",
    "Patna",
    "Vadodara",
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCity,
      validator: validator,
      decoration: InputDecoration(
        hintText: "Select a city",
        fillColor: Color.fromARGB(255, 255, 225, 229),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black38),
        ),
      ),
      items: cities.map((city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: onCityChanged,
    );
  }
}
