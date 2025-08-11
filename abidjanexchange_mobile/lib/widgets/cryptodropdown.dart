import 'package:flutter/material.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';

class CryptoSelectorInput extends StatefulWidget {
  final Function(String?)? onChanged; // Ajout du callback onChanged

  const CryptoSelectorInput({super.key, this.onChanged});

  @override
  _CryptoSelectorInputState createState() => _CryptoSelectorInputState();
}

class _CryptoSelectorInputState extends State<CryptoSelectorInput> {
  String? selectedCryptoName;
  String? selectedCryptoIcon;

  final List<Map<String, String>> cryptos = [
    {"name": "Bitcoin", "icon": "lib/images/logo.jpg"},
    {"name": "Ethereum", "icon": "lib/images/logo.jpg"},
    {"name": "Litecoin", "icon": "lib/images/logo.jpg"},
    {"name": "Ripple", "icon": "lib/images/logo.jpg"},
    {"name": "Cardano", "icon": "lib/images/logo.jpg"},
    {"name": "Polkadot", "icon": "lib/images/logo.jpg"},
  ];

  void _showCryptoPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: cryptos.map((crypto) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCryptoName = crypto["name"];
                    selectedCryptoIcon = crypto["icon"];
                  });
                  widget.onChanged?.call(selectedCryptoName); // Appeler onChanged
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
                        crypto["icon"]!,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(height: 5),
                    
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
      onTap: _showCryptoPicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            if (selectedCryptoIcon != null)
              Image.asset(selectedCryptoIcon!, width: 30, height: 30),
            if (selectedCryptoName != null) ...[
              const SizedBox(width: 10),
              Text(
                selectedCryptoName!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
            ],
            if (selectedCryptoName == null)
              const Text(
                "Sélectionnez une crypto",
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