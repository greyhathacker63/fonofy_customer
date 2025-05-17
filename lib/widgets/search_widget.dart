import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/WhiteScreen.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Future<List<String>> Function(String) onSearch;

  const SearchWidget({
    Key? key,
    this.hintText,
    required this.onSearch,
    this.controller,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSearch(String value) async {
    final query = value.trim();
    await widget.onSearch(query); // just trigger parent handler
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          // Navigate to full search screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WhiteScreen()), 
          );
        },
        child: AbsorbPointer(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Search...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white38,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blueGrey, width: 5.0),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
