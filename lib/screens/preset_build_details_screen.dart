import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/component_models.dart';
import '../data/repositories/component_repository.dart';

class PresetBuildDetailsScreen extends StatefulWidget {
  final PresetBuild preset;
  final String buildType;

  const PresetBuildDetailsScreen({
    Key? key,
    required this.preset,
    required this.buildType,
  }) : super(key: key);

  @override
  _PresetBuildDetailsScreenState createState() =>
      _PresetBuildDetailsScreenState();
}

class _PresetBuildDetailsScreenState extends State<PresetBuildDetailsScreen> {
  late Future<Map<String, dynamic>> _buildDetailsFuture;

  @override
  void initState() {
    super.initState();
    _buildDetailsFuture = _loadBuildDetails();
  }

  Future<Map<String, dynamic>> _loadBuildDetails() async {
    final repository = Provider.of<ComponentRepository>(context, listen: false);

    final cpu = await repository.getCPUById(widget.preset.cpuId);
    final gpu = await repository.getGPUById(widget.preset.gpuId);
    final ram = await repository.getRAMById(widget.preset.ramId);
    final storage = await repository.getStorageById(widget.preset.storageId);
    final motherboard =
        await repository.getMotherboardById(widget.preset.motherboardId);

    PSU? psu;
    if (widget.buildType == 'PC') {
      if (widget.preset.psuId != null) {
        psu = await repository.getPSUById(widget.preset.psuId!);
      } else {
        // Calculate total wattage and recommend a PSU
        final totalWattage = await repository.calculateTotalWattage(
          cpuId: widget.preset.cpuId,
          gpuId: widget.preset.gpuId,
        );
        psu = await repository.getRecommendedPSU(totalWattage);
      }
    }

    final totalWattage = await repository.calculateTotalWattage(
      cpuId: widget.preset.cpuId,
      gpuId: widget.preset.gpuId,
    );

    final supportedSoftware = await repository.getSupportedSoftware(
      cpuId: widget.preset.cpuId,
      gpuId: widget.preset.gpuId,
    );

    return {
      'cpu': cpu,
      'gpu': gpu,
      'ram': ram,
      'storage': storage,
      'motherboard': motherboard,
      'psu': psu,
      'totalWattage': totalWattage,
      'supportedSoftware': supportedSoftware,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.buildType} Build Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _buildDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading build details: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No build details available'),
            );
          }

          final buildDetails = snapshot.data!;
          final CPU? cpu = buildDetails['cpu'];
          final GPU? gpu = buildDetails['gpu'];
          final RAM? ram = buildDetails['ram'];
          final Storage? storage = buildDetails['storage'];
          final Motherboard? motherboard = buildDetails['motherboard'];
          final PSU? psu = buildDetails['psu'];
          final int totalWattage = buildDetails['totalWattage'];
          final List<String> supportedSoftware =
              buildDetails['supportedSoftware'];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.preset.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Use Case: ${widget.preset.useCase}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Divider(height: 24),
                        _buildComponentSection('CPU', cpu?.name ?? 'N/A', [
                          'Brand: ${cpu?.brand ?? 'N/A'}',
                          'Cores: ${cpu?.cores ?? 'N/A'}',
                          'Clock Speed: ${cpu?.clockSpeed ?? 'N/A'} GHz',
                          'Benchmark Score: ${cpu?.benchmarkScore ?? 'N/A'}',
                        ]),
                        _buildComponentSection('GPU', gpu?.name ?? 'N/A', [
                          'Brand: ${gpu?.brand ?? 'N/A'}',
                          'VRAM: ${gpu?.vram ?? 'N/A'} GB',
                          'Benchmark Score: ${gpu?.benchmarkScore ?? 'N/A'}',
                        ]),
                        _buildComponentSection('RAM', ram?.name ?? 'N/A', [
                          'Brand: ${ram?.brand ?? 'N/A'}',
                          'Capacity: ${ram?.capacity ?? 'N/A'} GB',
                          'Type: ${ram?.type ?? 'N/A'}',
                          'Speed: ${ram?.speed ?? 'N/A'} MHz',
                        ]),
                        _buildComponentSection(
                            'Storage', storage?.name ?? 'N/A', [
                          'Brand: ${storage?.brand ?? 'N/A'}',
                          'Capacity: ${storage?.capacity ?? 'N/A'} GB',
                          'Type: ${storage?.type ?? 'N/A'}',
                          'Interface: ${storage?.interface ?? 'N/A'}',
                        ]),
                        _buildComponentSection(
                            'Motherboard', motherboard?.name ?? 'N/A', [
                          'Brand: ${motherboard?.brand ?? 'N/A'}',
                          'Chipset: ${motherboard?.chipset ?? 'N/A'}',
                          'Socket: ${motherboard?.socketType ?? 'N/A'}',
                          'Form Factor: ${motherboard?.formFactor ?? 'N/A'}',
                        ]),
                        if (widget.buildType == 'PC')
                          _buildComponentSection(
                              'Power Supply', psu?.name ?? 'N/A', [
                            'Brand: ${psu?.brand ?? 'N/A'}',
                            'Wattage: ${psu?.wattage ?? 'N/A'} W',
                            'Certification: ${psu?.certification ?? 'N/A'}',
                          ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Performance Metrics',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildMetricRow(
                          'Total Power Consumption',
                          '$totalWattage W',
                          Icons.power,
                        ),
                        const SizedBox(height: 8),
                        _buildMetricRow(
                          'CPU Benchmark',
                          '${cpu?.benchmarkScore ?? 'N/A'}',
                          Icons.speed,
                        ),
                        const SizedBox(height: 8),
                        _buildMetricRow(
                          'GPU Benchmark',
                          '${gpu?.benchmarkScore ?? 'N/A'}',
                          Icons.speed,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Supported Software',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        supportedSoftware.isEmpty
                            ? const Text('No software information available')
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: supportedSoftware
                                    .map((software) => Chip(
                                          label: Text(software),
                                          backgroundColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                        ))
                                    .toList(),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildComponentSection(
      String title, String subtitle, List<String> details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                child: Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
