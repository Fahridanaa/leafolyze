import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final String? hintText;

  const CustomSearchBar(
      {super.key,
      required this.onChanged,
      required this.onSubmitted,
      this.hintText = "Search here..."});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SearchBar(
          hintText: hintText,
          leading: const Icon(Icons.search),
          backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
          elevation: WidgetStateProperty.all(0),
          constraints: const BoxConstraints(
            maxHeight: 40,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
