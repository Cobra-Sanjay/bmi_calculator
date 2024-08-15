import 'package:flutter/material.dart';

class CreditPage extends StatelessWidget {
  const CreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: Container(
        color: Colors.black, 
        child: const Stack(
          children: [
            AnimatedCreditText(
              text: "COBRA\nXYZ_Chico\nSHADOW",
              textColor: Colors.white,
              textSize: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCreditText extends StatefulWidget {
  final String text;
  final Color textColor;
  final double textSize;

  const AnimatedCreditText({super.key, 
    required this.text,
    required this.textColor,
    required this.textSize,
  });

  @override
  _AnimatedCreditTextState createState() => _AnimatedCreditTextState();
}

class _AnimatedCreditTextState extends State<AnimatedCreditText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(); 

    _animation = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height * _animation.value),
            child: SizedBox(
              height: MediaQuery.of(context).size.height, 
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.text.split('\n').map((line) {
                    return Text(
                      line,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: widget.textSize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
