import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String hint;
  final void Function() onChanged;
  final String? value;

  const SearchableDropdown({
    required this.items,
    required this.hint,
    required this.onChanged,
    this.value,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;
  List<Map<String, dynamic>> _filteredItems = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => (item['text'] as String)!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
    _overlayEntry?.markNeedsBuild();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    // Get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSpace =
        screenHeight - renderBox.localToGlobal(Offset.zero).dy - size.height;

    // Calculate maximum height for dropdown
    final maxHeight = bottomSpace - 10; // Leave 10 pixels padding
    final itemHeight = 56.0; // Approximate height of ListTile
    final calculatedHeight = _filteredItems.length * itemHeight;
    final dropdownHeight = calculatedHeight.clamp(0.0, maxHeight);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: dropdownHeight, // Use calculated height
                minHeight: 56.0, // Ensure at least one item is visible
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredItems[index]['text'] ?? ''),
                    onTap: () {
                      widget.onChanged();
                      _searchController.text =
                          _filteredItems[index]['text'] ?? '';
                      _hideOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: Icon(
                _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(),
            ),
            onTap: () {
              if (!_isOpen) {
                _showOverlay();
              }
            },
            onChanged: (value) {
              _filterItems(value);
              if (!_isOpen) {
                _showOverlay();
              }
            },
          ),
        ],
      ),
    );
  }
}
