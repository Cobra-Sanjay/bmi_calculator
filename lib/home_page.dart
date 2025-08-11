import 'package:flutter/material.dart';
import 'result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _gender;
  String _weightUnit = 'kg';
  String _heightUnit = 'cm';

  void _calculateBMI() {
    final height = _parseHeight();
    final weight = _parseWeight();

    if (height != null && weight != null) {
      final bmi = weight / ((height / 100) * (height / 100));
      final bmiCategory = _getBMICategory(bmi);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            bmi: bmi,
            bmiCategory: bmiCategory,
            height: height,
            age: int.tryParse(_ageController.text) ?? 0,
            gender: _gender ?? '',
          ),
        ),
      );
    }
  }

  double? _parseHeight() {
    double? height = double.tryParse(_heightController.text);
    if (_heightUnit == 'ft' && height != null) {
      height *= 30.48;
    }
    return height;
  }

  double? _parseWeight() {
    double? weight = double.tryParse(_weightController.text);
    if (_weightUnit == 'lbs' && weight != null) {
      weight *= 0.453592;
    }
    return weight;
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal weight";
    if (bmi < 29.9) return "Overweight";
    return "Obesity";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAgeInput(),
            const SizedBox(height: 30),
            _buildGenderSelector(),
            const SizedBox(height: 30),
            _buildHeightInput(),
            const SizedBox(height: 30),
            _buildWeightInput(),
            const SizedBox(height: 20),
            _buildCalculateButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeInput() {
    return TextField(
      controller: _ageController,
      decoration: const InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.orange,
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        const Text(
          'Gender:',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(width: 10),
        _buildGenderButton('Male', Icons.male),
        const SizedBox(width: 10),
        _buildGenderButton('Female', Icons.female),
      ],
    );
  }

  Widget _buildGenderButton(String gender, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _gender == gender ? Colors.orange : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeightInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _heightController,
            decoration: InputDecoration(labelText: 'Height ($_heightUnit)'),
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.orange,
          ),
        ),
        const SizedBox(width: 10),
        _buildUnitToggleButtons(
          currentUnit: _heightUnit,
          units: ['cm', 'ft'],
          onChanged: (value) {
            setState(() {
              _heightUnit = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildWeightInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _weightController,
            decoration: InputDecoration(labelText: 'Weight ($_weightUnit)'),
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.orange,
          ),
        ),
        const SizedBox(width: 10),
        _buildUnitToggleButtons(
          currentUnit: _weightUnit,
          units: ['kg', 'lbs'],
          onChanged: (value) {
            setState(() {
              _weightUnit = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildUnitToggleButtons({
    required String currentUnit,
    required List<String> units,
    required void Function(String) onChanged,
  }) {
    return ToggleButtons(
      isSelected: units.map((unit) => unit == currentUnit).toList(),
      onPressed: (index) {
        onChanged(units[index]);
      },
      children: units.map((unit) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(unit, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }

  Widget _buildCalculateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _calculateBMI,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: const Text('Calculate'),
      ),
    );
  }
}
