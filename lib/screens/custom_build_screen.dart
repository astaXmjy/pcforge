import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/component_models.dart';
import '../data/repositories/component_repository.dart';
import 'component_selection_screen.dart';

class CustomBuildScreen extends StatefulWidget {
  const CustomBuildScreen({Key? key}) : super(key: key);

  @override
  _CustomBuildScreenState createState() => _CustomBuildScreenState();
}

class _CustomBuildScreenState extends State<CustomBuildScreen> {
  CPU? selectedCPU;
  GPU? selectedGPU;
  RAM? selectedRAM;
  Storage? selectedStorage;
  Motherboard? selectedMotherboard;
  PSU? selectedPSU;
  int totalWattage = 0;
  List<String> supportedSoftware = [];

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<ComponentRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom PC Build'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Components',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildComponentCard(
              title: 'CPU',
              subtitle: selectedCPU?.name ?? 'Select a CPU',
              details: selectedCPU != null
                  ? [
                      'Brand: ${selectedCPU!.brand}',
                      'Cores: ${selectedCPU!.cores}',
                      'Clock Speed: ${selectedCPU!.clockSpeed} GHz',
                      'TDP: ${selectedCPU!.tdp} W',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<CPU>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<CPU>(
                      title: 'Select CPU',
                      getComponents: () => repository.getAllCPUs(),
                      buildItemWidget: (cpu) => ListTile(
                        title: Text(cpu.name),
                        subtitle: Text(
                            '${cpu.brand} - ${cpu.cores} cores - ${cpu.clockSpeed} GHz'),
                        trailing: Text('${cpu.tdp} W'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedCPU = result;
                    _updateTotalWattage();
                    _updateSupportedSoftware();
                  });
                }
              },
            ),
            _buildComponentCard(
              title: 'GPU',
              subtitle: selectedGPU?.name ?? 'Select a GPU',
              details: selectedGPU != null
                  ? [
                      'Brand: ${selectedGPU!.brand}',
                      'VRAM: ${selectedGPU!.vram} GB',
                      'TDP: ${selectedGPU!.tdp} W',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<GPU>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<GPU>(
                      title: 'Select GPU',
                      getComponents: () => repository.getAllGPUs(),
                      buildItemWidget: (gpu) => ListTile(
                        title: Text(gpu.name),
                        subtitle: Text('${gpu.brand} - ${gpu.vram} GB VRAM'),
                        trailing: Text('${gpu.tdp} W'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedGPU = result;
                    _updateTotalWattage();
                    _updateSupportedSoftware();
                  });
                }
              },
            ),
            _buildComponentCard(
              title: 'RAM',
              subtitle: selectedRAM?.name ?? 'Select RAM',
              details: selectedRAM != null
                  ? [
                      'Brand: ${selectedRAM!.brand}',
                      'Capacity: ${selectedRAM!.capacity} GB',
                      'Type: ${selectedRAM!.type}',
                      'Speed: ${selectedRAM!.speed} MHz',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<RAM>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<RAM>(
                      title: 'Select RAM',
                      getComponents: () => repository.getAllRAMs(),
                      buildItemWidget: (ram) => ListTile(
                        title: Text(ram.name),
                        subtitle: Text(
                            '${ram.brand} - ${ram.capacity} GB ${ram.type}'),
                        trailing: Text('${ram.speed} MHz'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedRAM = result;
                  });
                }
              },
            ),
            _buildComponentCard(
              title: 'Storage',
              subtitle: selectedStorage?.name ?? 'Select Storage',
              details: selectedStorage != null
                  ? [
                      'Brand: ${selectedStorage!.brand}',
                      'Capacity: ${selectedStorage!.capacity} GB',
                      'Type: ${selectedStorage!.type}',
                      'Interface: ${selectedStorage!.interface}',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<Storage>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<Storage>(
                      title: 'Select Storage',
                      getComponents: () => repository.getAllStorages(),
                      buildItemWidget: (storage) => ListTile(
                        title: Text(storage.name),
                        subtitle: Text(
                            '${storage.brand} - ${storage.capacity} GB ${storage.type}'),
                        trailing: Text(storage.interface),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedStorage = result;
                  });
                }
              },
            ),
            _buildComponentCard(
              title: 'Motherboard',
              subtitle: selectedMotherboard?.name ?? 'Select Motherboard',
              details: selectedMotherboard != null
                  ? [
                      'Brand: ${selectedMotherboard!.brand}',
                      'Chipset: ${selectedMotherboard!.chipset}',
                      'Socket: ${selectedMotherboard!.socketType}',
                      'Form Factor: ${selectedMotherboard!.formFactor}',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<Motherboard>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<Motherboard>(
                      title: 'Select Motherboard',
                      getComponents: () => repository.getAllMotherboards(),
                      buildItemWidget: (motherboard) => ListTile(
                        title: Text(motherboard.name),
                        subtitle: Text(
                            '${motherboard.brand} - ${motherboard.chipset}'),
                        trailing: Text(motherboard.socketType),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedMotherboard = result;
                  });
                }
              },
            ),
            _buildComponentCard(
              title: 'Power Supply',
              subtitle: selectedPSU?.name ?? 'Auto-select based on components',
              details: selectedPSU != null
                  ? [
                      'Brand: ${selectedPSU!.brand}',
                      'Wattage: ${selectedPSU!.wattage} W',
                      'Certification: ${selectedPSU!.certification}',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<PSU>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<PSU>(
                      title: 'Select Power Supply',
                      getComponents: () => repository.getAllPSUs(),
                      buildItemWidget: (psu) => ListTile(
                        title: Text(psu.name),
                        subtitle: Text('${psu.brand} - ${psu.certification}'),
                        trailing: Text('${psu.wattage} W'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedPSU = result;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
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
                      'Build Summary',
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
                    const SizedBox(height: 16),
                    const Text(
                      'Recommended PSU',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<PSU?>(
                      future: totalWattage > 0
                          ? repository.getRecommendedPSU(totalWattage)
                          : Future.value(null),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final recommendedPSU = snapshot.data;
                        if (recommendedPSU == null) {
                          return const Text(
                              'Select CPU and GPU to get a recommendation');
                        }

                        return ListTile(
                          title: Text(recommendedPSU.name),
                          subtitle: Text(
                              '${recommendedPSU.brand} - ${recommendedPSU.certification}'),
                          trailing: Text('${recommendedPSU.wattage} W'),
                          onTap: () {
                            setState(() {
                              selectedPSU = recommendedPSU;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Supported Software',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    supportedSoftware.isEmpty
                        ? const Text(
                            'Select CPU and GPU to see supported software')
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
      ),
    );
  }

  Widget _buildComponentCard({
    required String title,
    required String subtitle,
    required List<String> details,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: subtitle.startsWith('Select') ? Colors.grey : null,
                ),
              ),
              if (details.isNotEmpty) ...[
                const SizedBox(height: 8),
                ...details.map((detail) => Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Text(
                        detail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    )),
              ],
            ],
          ),
        ),
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

  Future<void> _updateTotalWattage() async {
    if (selectedCPU != null && selectedGPU != null) {
      final repository =
          Provider.of<ComponentRepository>(context, listen: false);
      final wattage = await repository.calculateTotalWattage(
        cpuId: selectedCPU!.id,
        gpuId: selectedGPU!.id,
      );
      setState(() {
        totalWattage = wattage;
      });
    }
  }

  Future<void> _updateSupportedSoftware() async {
    if (selectedCPU != null && selectedGPU != null) {
      final repository =
          Provider.of<ComponentRepository>(context, listen: false);
      final software = await repository.getSupportedSoftware(
        cpuId: selectedCPU!.id,
        gpuId: selectedGPU!.id,
      );
      setState(() {
        supportedSoftware = software;
      });
    }
  }
}
