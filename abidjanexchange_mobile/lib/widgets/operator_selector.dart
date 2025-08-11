import 'package:flutter/material.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';

class OperateurSelectorInput extends StatefulWidget {

  final Function(String?)? onChanged; // Ajout du callback onChanged

  const OperateurSelectorInput({super.key , this.onChanged});

  @override
  _OperateurSelectorInputState createState() => _OperateurSelectorInputState();
}

class _OperateurSelectorInputState extends State<OperateurSelectorInput> {
  String? selectedOperateurName;
  String? selectedOperateurIcon;

  final List<Map<String, String>> operateurs = [
    {"name": "Wave", "icon": "lib/images/wavelogo.jpg"},
    {"name": "Orange", "icon": "lib/images/orangelogo.jpg"},
    {"name": "Moov", "icon": "lib/images/moovlogo.png"},
    {"name": "MTN", "icon": "lib/images/mtnlogo.png"},
  ];

  void _showOperateurPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
  return Container(
    height: 350,
    padding: const EdgeInsets.all(10),
    child: GridView.count(
      crossAxisCount: 2,  // <-- ici, 2 par rangée
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.4, // >1 = rectangle plus large que haut
      children: operateurs.map((operateur) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOperateurName = operateur["name"];
              selectedOperateurIcon = operateur["icon"];
            });
            widget.onChanged?.call(selectedOperateurName); // Appeler onChanged
            Navigator.pop(context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  operateur["icon"]!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                operateur["name"]!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showOperateurPicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            if (selectedOperateurIcon != null)
              Image.asset(selectedOperateurIcon!, width: 30, height: 30),
            if (selectedOperateurName != null) ...[
              const SizedBox(width: 10),
              Text(
                selectedOperateurName!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
            ],
            if (selectedOperateurName == null)
              const Text(
                "Sélectionnez un opérateur",
                style: TextStyle(color: Colors.grey),
              ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
