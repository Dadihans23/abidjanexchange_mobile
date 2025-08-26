import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class recentActivities extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> tags;
  final List<Color>? tagColors;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final VoidCallback? onTap;

  const recentActivities({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tags,
    this.tagColors,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.trailingIcon,
    required this.trailingIconColor,
    this.onTap,
  }) : super(key: key);

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    final width = screenWidth(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white ,
          borderRadius: BorderRadius.circular(07)
        ),
        child: Padding(
          
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  leadingIcon,
                  color: leadingIconColor,
                  size: width * 0.07,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: width < 360 ? 15 : 16,
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: width < 360 ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: width < 360 ? 15 : 16,
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: width < 360 ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
