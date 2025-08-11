import 'package:flutter/material.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const Button({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + _animationController.value * 0.04,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: AppColors.primary, // Jaune orangé
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    color: AppColors.textOnPrimary, // Noir
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}