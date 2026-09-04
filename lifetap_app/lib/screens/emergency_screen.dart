import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/mock_data.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _symptomsController = TextEditingController();
  bool _locationCaptured = false;
  bool _isSubmitting = false;

  // Mock coordinates - Stage 5E will replace this with the geolocator
  // package's actual device GPS reading.
  double? _latitude;
  double? _longitude;

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }

  void _captureLocation() {
    // TODO (Stage 5E): use geolocator to get Position.latitude/longitude,
    // handling permission prompts and denial.
    setState(() {
      _latitude = 12.9716;
      _longitude = 77.5946;
      _locationCaptured = true;
    });
  }

  void _submit() {
    if (_symptomsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the symptoms.')),
      );
      return;
    }
    if (!_locationCaptured) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture location first.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // TODO (Stage 5D): replace with
    //   final result = await ApiService.instance.reportEmergency(
    //     symptoms: _symptomsController.text,
    //     latitude: _latitude!, longitude: _longitude!,
    //   );
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      final result = MockData.classify(_symptomsController.text);
      setState(() => _isSubmitting = false);
      Navigator.pushNamed(context, '/result', arguments: result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Emergency')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Describe what is happening',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _symptomsController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText:
                      'e.g. "Severe chest pain and difficulty breathing"',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  // TODO (Stage 5F): wire this to speech_to_text and
                  // append the transcribed text into the field above.
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice input arrives in Stage 5F.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.mic),
                  label: const Text('Speak instead'),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: AppSpacing.sm),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: _locationCaptured ? AppColors.success : Colors.grey,
                  ),
                  title: Text(
                    _locationCaptured
                        ? '$_latitude, $_longitude'
                        : 'Location not captured yet',
                  ),
                  trailing: TextButton(
                    onPressed: _captureLocation,
                    child: Text(_locationCaptured ? 'Update' : 'Get My Location'),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.emergency,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('SUBMIT EMERGENCY',
                        style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
