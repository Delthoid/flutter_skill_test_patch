import 'package:flutter/material.dart';

class HeaderWithSearchBar extends StatefulWidget {
  const HeaderWithSearchBar({super.key});

  @override
  State<HeaderWithSearchBar> createState() => _HeaderWithSearchBarState();
}

class _HeaderWithSearchBarState extends State<HeaderWithSearchBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 138,
      child: Stack(
        children: [
          Container(
            color: theme.colorScheme.primary,
            height: 110,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(12, 0, 0, 0),
                      offset: Offset(0, 4),
                      blurRadius: 4
                    )
                  ]
                ),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'What are you looking for?'
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    controller: TextEditingController(text: ''),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}