import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  String ?hintText;
  
  final TextEditingController? controller;
  final Future<List<String>> Function(String) onSearch;


SearchWidget({
    Key? key,
    this.hintText,
    required this.onSearch, this.controller, 
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;
  List<String> _searchResults = [];

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
  if (query.isNotEmpty) {
    final results = await widget.onSearch(query);
    setState(() {
      _searchResults = results;
    });
  } else {
    setState(() {
      _searchResults = [];
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _controller,
            onChanged: _handleSearch,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        widget.onSearch('');
                        setState(() {
                          _searchResults = [];
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Results List
        if (_searchResults.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_searchResults[index]),
                onTap: () {
                  // Handle item selection (optional)
                  print('Selected: ${_searchResults[index]}');
                },
              );
            },
          ),
      ],
    );
  }
}
