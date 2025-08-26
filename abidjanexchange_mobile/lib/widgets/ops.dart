import 'package:flutter/material.dart';

class OperateurSelector extends StatefulWidget {
  final List<Map<String, dynamic>> operateurs;
  final ValueChanged<Map<String, dynamic>> onSelected;

  const OperateurSelector({
    Key? key,
    required this.operateurs,
    required this.onSelected,
  }) : super(key: key);

  @override
  _OperateurSelectorState createState() => _OperateurSelectorState();
}

class _OperateurSelectorState extends State<OperateurSelector> {
  int? selectedIndex;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    final width = screenWidth(context);

    return Column(
      children: List.generate(widget.operateurs.length, (index) {
        final operateur = widget.operateurs[index];
        final isSelected = selectedIndex == index;

        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onSelected(operateur);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          operateur["icon"],
                          width: width * 0.10,
                          height: width * 0.10,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          operateur["name"],
                          style: TextStyle(
                            fontSize: width < 360 ? 14 : 15,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1,
                          ),
                        ),
                        Text(
                          operateur["fee"] ?? "",
                          style: TextStyle(
                            fontSize: width < 360 ? 13 : 14,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isSelected)
                  Icon(
                    Icons.check,
                    color: Colors.blueAccent,
                    size: width * 0.07,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
