import 'package:flutter/material.dart';

class ComponentSelectionScreen<T> extends StatefulWidget {
  final String title;
  final Future<List<T>> Function() getComponents;
  final Widget Function(T) buildItemWidget;

  const ComponentSelectionScreen({
    Key? key,
    required this.title,
    required this.getComponents,
    required this.buildItemWidget,
  }) : super(key: key);

  @override
  _ComponentSelectionScreenState<T> createState() =>
      _ComponentSelectionScreenState<T>();
}

class _ComponentSelectionScreenState<T>
    extends State<ComponentSelectionScreen<T>> {
  late Future<List<T>> _componentsFuture;
  String _searchQuery = '';
  List<T> _filteredComponents = [];
  List<T> _allComponents = [];

  @override
  void initState() {
    super.initState();
    _componentsFuture = widget.getComponents();
  }

  void _filterComponents(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredComponents = List.from(_allComponents);
      } else {
        // This is a simple filter that works with any object
        // You might want to implement a more specific filter based on your component types
        _filteredComponents = _allComponents.where((component) {
          final String componentString = component.toString().toLowerCase();
          return componentString.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter component name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterComponents,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<T>>(
              future: _componentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading components: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No components available'),
                  );
                }

                // Initialize all components and filtered components if not already done
                if (_allComponents.isEmpty) {
                  _allComponents = snapshot.data!;
                  _filteredComponents = List.from(_allComponents);
                }

                return ListView.builder(
                  itemCount: _searchQuery.isEmpty
                      ? _allComponents.length
                      : _filteredComponents.length,
                  itemBuilder: (context, index) {
                    final component = _searchQuery.isEmpty
                        ? _allComponents[index]
                        : _filteredComponents[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, component);
                      },
                      child: widget.buildItemWidget(component),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
