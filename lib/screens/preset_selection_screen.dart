import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/repositories/component_repository.dart';
import 'preset_build_details_screen.dart';

class PresetSelectionScreen extends StatelessWidget {
  final String buildType; // 'PC' or 'Laptop'

  const PresetSelectionScreen({
    Key? key,
    required this.buildType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$buildType Presets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a use case for your $buildType:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildUseCaseCard(
                    context,
                    useCase: 'Gaming',
                    icon: Icons.sports_esports,
                    description: 'For gaming enthusiasts',
                  ),
                  _buildUseCaseCard(
                    context,
                    useCase: 'Editing',
                    icon: Icons.movie_filter,
                    description: 'For video and photo editing',
                  ),
                  _buildUseCaseCard(
                    context,
                    useCase: 'CAD',
                    icon: Icons.architecture,
                    description: 'For CAD and 3D modeling',
                  ),
                  _buildUseCaseCard(
                    context,
                    useCase: 'Office',
                    icon: Icons.business_center,
                    description: 'For everyday productivity',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUseCaseCard(
    BuildContext context, {
    required String useCase,
    required IconData icon,
    required String description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () async {
          final repository =
              Provider.of<ComponentRepository>(context, listen: false);
          final presets = await repository.getPresetBuildsByTypeAndUseCase(
              buildType, useCase);

          if (presets.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PresetBuildDetailsScreen(
                  preset: presets.first,
                  buildType: buildType,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No presets available for this use case'),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 4),
              Text(
                useCase,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
