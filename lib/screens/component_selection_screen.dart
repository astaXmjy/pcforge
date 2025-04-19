import 'package:flutter/material.dart';
import '../data/models/component_models.dart';

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
      _searchQuery = query.toLowerCase(); // Convert query to lowercase for case-insensitive search
      if (query.isEmpty) {
        _filteredComponents = List.from(_allComponents);
      } else {
        _filteredComponents = _allComponents.where((component) {
          // Check the type of component and use appropriate properties for searching
          if (component is CPU) {
            return component.name.toLowerCase().contains(_searchQuery) ||
                component.brand.toLowerCase().contains(_searchQuery);
          } else if (component is GPU) {
            return component.name.toLowerCase().contains(_searchQuery) ||
                component.brand.toLowerCase().contains(_searchQuery);
          } else if (component is RAM) {
            return component.name.toLowerCase().contains(_searchQuery) ||
                component.brand.toLowerCase().contains(_searchQuery) ||
                component.type.toLowerCase().contains(_searchQuery);
          } else if (component is Storage) {
            return component.name.toLowerCase().contains(_searchQuery) ||
                component.brand.toLowerCase().contains(_searchQuery) ||
                component.type.toLowerCase().contains(_searchQuery);
          } else if (component is Motherboard) {
            return component.name.toLowerCase().contains(_searchQuery) ||
                component.brand.toLowerCase().contains(_searchQuery) ||
                component.chipset.toLowerCase().contains(_searchQuery) ||
                component.socketType.toLowerCase().contains(_searchQuery);
          } else if (component is PSU) {
            return component.name.toLowerCase().contains(_searchQuery) ||
                component.brand.toLowerCase().contains(_searchQuery) ||
                component.certification.toLowerCase().contains(_searchQuery);
          } else {
            // Fallback for any other type - use toString() as before
            return component.toString().toLowerCase().contains(_searchQuery);
          }
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

                final componentsToShow = _searchQuery.isEmpty
                    ? _allComponents
                    : _filteredComponents;

                if (componentsToShow.isEmpty) {
                  return const Center(
                    child: Text('No matching components found'),
                  );
                }

                return ListView.builder(
                  itemCount: componentsToShow.length,
                  itemBuilder: (context, index) {
                    final component = componentsToShow[index];
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