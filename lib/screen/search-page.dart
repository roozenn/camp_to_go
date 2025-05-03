import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _searchResults = [
    "Forclaz Men's MT900 Symbium2",
    "Forclaz Men's MT900 Symbium2",
    "Forclaz Men's MT900 Symbium2",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Row with Mic outside
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        hintText: 'Forclaz MT900',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black54,
                        ),
                        suffixIcon:
                            _controller.text.isNotEmpty
                                ? GestureDetector(
                                  onTap: () {
                                    _controller.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                )
                                : null,
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.mic_none, size: 20, color: Colors.black45),
                ],
              ),
              const SizedBox(height: 20),
              // Search Results
              ..._searchResults.map(
                (result) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
