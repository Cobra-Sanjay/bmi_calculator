import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  final String bmiCategory;
  final double height;
  final int age;
  final String gender;

  const ResultPage({
    super.key, 
    required this.bmi,
    required this.bmiCategory,
    required this.height,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your current BMI'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bmiDisplay(bmi),
            const SizedBox(height: 40),
            _bmiGradientBar(),
            const SizedBox(height: 30),
            _buildLegend(),
            const SizedBox(height: 10),
            _bmiCategoryDisplay(bmiCategory),
            const SizedBox(height: 10),
            const Divider(),
            _buildListTile('Height (cm) : ', height.toStringAsFixed(1)),
            const SizedBox(height: 10),
            _buildListTile(
              'Suggested weight (kg) : ',
              '${(18.5 * (height / 100) * (height / 100)).toStringAsFixed(1)} ~ ${(24.9 * (height / 100) * (height / 100)).toStringAsFixed(1)}'
            ),
          ],
        ),
      ),
    );
  }

  Widget _bmiDisplay(double bmi) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Text(
        bmi.toStringAsFixed(1),
        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _bmiGradientBar() {
    return Container(
      height: 10,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
          stops: [0.0, 0.33, 0.66, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _bmiCategoryDisplay(String category) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Text(
        category,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _getCategoryColor(category)),
      ),
    );
  }

  Widget _buildListTile(String title, String trailing) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: Text(trailing, style: const TextStyle(fontSize: 16)),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal weight':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obesity':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _legendItem(Colors.blue, 'Underweight'),
        _legendItem(Colors.green, 'Normal weight'),
        _legendItem(Colors.orange, 'Overweight'),
        _legendItem(Colors.red, 'Obesity'),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
