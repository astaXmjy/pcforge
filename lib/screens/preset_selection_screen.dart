import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/repositories/component_repository.dart';
import 'preset_build_details_screen.dart';
import 'laptop_preset_details_screen.dart';

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
            const SizedBox(height: 12),
            // Show tip for laptop builds
            if (buildType == 'Laptop')
              Card(
                color: Colors.blue.shade50,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.amber.shade700),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "TIP: IF YOU'RE A CURRENT OR ASPIRING DEVELOPER, DESIGNER, OR ARCHITECT, THE GAMING PRESET IS YOUR BEST CHOICE.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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

          if (buildType == 'Laptop') {
            // Use laptop presets for laptop builds
            final laptopPresets = await repository
                .getLaptopPresetBuildsByTypeAndUseCase(buildType, useCase);

            if (laptopPresets.isNotEmpty) {
              // Navigate to correct preset details screen based on build type
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaptopPresetDetailsScreen(
                    preset: laptopPresets.first,
                    buildType: buildType,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('No laptop presets available for this use case'),
                ),
              );
            }
          } else {
            // Use PC presets for PC builds
            final presets = await repository.getPresetBuildsByTypeAndUseCase(
                buildType, useCase);

            if (presets.isNotEmpty) {
              // Find both high-end and mid-range presets
              final highEndPreset = presets.firstWhere(
                (preset) => preset.name.toLowerCase().contains('high'),
                orElse: () => presets.first,
              );

              final midRangePreset = presets.firstWhere(
                (preset) => preset.name.toLowerCase().contains('mid'),
                orElse: () => presets.first,
              );

              // Show dialog to choose between high-end and mid-range if both exist
              if (highEndPreset.id != midRangePreset.id) {
                // Both high-end and mid-range presets exist, show selection dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select $useCase PC Type'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('High-End'),
                            subtitle:
                                const Text('Best performance, higher cost'),
                            leading: const Icon(Icons.star),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PresetBuildDetailsScreen(
                                    preset: highEndPreset,
                                    buildType: buildType,
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: const Text('Mid-Range'),
                            subtitle:
                                const Text('Good performance, moderate cost'),
                            leading: const Icon(Icons.thumb_up),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PresetBuildDetailsScreen(
                                    preset: midRangePreset,
                                    buildType: buildType,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                // Only one preset exists, navigate directly
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PresetBuildDetailsScreen(
                      preset: presets.first,
                      buildType: buildType,
                    ),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No presets available for this use case'),
                ),
              );
            }
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
