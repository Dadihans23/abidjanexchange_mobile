import 'package:abidjanexchange_mobile/screens/buyin_trait.dart';
import 'package:abidjanexchange_mobile/widgets/operator_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/widgets/cryptodropdown.dart';
import 'package:flutter/services.dart';

class AchatVenteScreen extends StatefulWidget {
  const AchatVenteScreen({super.key});

  @override
  _AchatVenteScreenState createState() => _AchatVenteScreenState();
}

class _AchatVenteScreenState extends State<AchatVenteScreen> {
  bool isAchat = true; // true = Achat, false = Vente
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _cfaController = TextEditingController();
  final TextEditingController _numeroDebitController = TextEditingController();
  String? selectedOperateur;
  String? selectedCrypto; // Pour stocker la cryptomonnaie sélectionnée
  final double conversionRate = 613.0; // Taux de conversion : 1 USD = 613 CFA
  bool _isUpdating = false; // Pour éviter les boucles infinies

  final List<Map<String, dynamic>> operateurs = [
    {"name": "Wave", "icon": "lib/images/logo.jpg"},
    {"name": "Wave", "icon": "lib/images/logo.jpg"},
    {"name": "Wave", "icon": "lib/images/logo.jpg"},
    {"name": "Wave", "icon": "lib/images/logo.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    // Ajouter des listeners pour gérer les conversions bidirectionnelles
    _montantController.addListener(_updateCfaFromUsd);
    _cfaController.addListener(_updateUsdFromCfa);
    // Pré-remplir l'indicatif +225
    _numeroDebitController.text = "+225 ";
  }

  void _showCupertinoDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Alerte", style: TextStyle(color: AppColors.textPrimary)),
          content: Text(message, style: const TextStyle(color: AppColors.textSecondary)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Okay", style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateCfaFromUsd() {
    if (_isUpdating) return; // Éviter les boucles infinies
    _isUpdating = true;

    if (_montantController.text.isNotEmpty) {
      try {
        final usd = double.parse(_montantController.text.replaceAll(',', '.'));
        final cfa = usd * conversionRate;
        setState(() {
          _cfaController.text = cfa.toStringAsFixed(2);
        });
      } catch (e) {
        setState(() {
          _cfaController.text = '';
        });
      }
    } else {
      setState(() {
        _cfaController.text = '';
      });
    }
    _isUpdating = false;
  }

  void _updateUsdFromCfa() {
    if (_isUpdating) return; // Éviter les boucles infinies
    _isUpdating = true;

    if (_cfaController.text.isNotEmpty) {
      try {
        final cfa = double.parse(_cfaController.text.replaceAll(',', '.'));
        final usd = cfa / conversionRate;
        setState(() {
          _montantController.text = usd.toStringAsFixed(2);
        });
      } catch (e) {
        setState(() {
          _montantController.text = '';
        });
      }
    } else {
      setState(() {
        _montantController.text = '';
      });
    }
    _isUpdating = false;
  }

  @override
  void dispose() {
    _montantController.dispose();
    _cfaController.dispose();
    _numeroDebitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppColors.background),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Achat / Vente",
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle Achat / Vente
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isAchat = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isAchat ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Acheter",
                              style: TextStyle(
                                color: AppColors.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isAchat = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isAchat ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Vendre",
                              style: TextStyle(
                                color: AppColors.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Choix Crypto
              const Text(
                "Choisissez la cryptomonnaie",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 10),
              CryptoSelectorInput(
                onChanged: (value) {
                  setState(() {
                    selectedCrypto = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // Montant en dollars
              const Text(
                "Montant en USD",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                controller: _montantController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Entrez le montant en USD",
                  hintStyle: const TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.background),
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.money_dollar,
                    color: AppColors.background,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Montant en CFA
              const Text(
                "Montant en CFA",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                controller: _cfaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Montant en CFA",
                  hintStyle: const TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.background),
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.money_dollar,
                    color: AppColors.background,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Moyen de paiement
              const Text(
                "Choisissez le moyen de paiement",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 10),
              OperateurSelectorInput(
                onChanged: (value) {
                  setState(() {
                    selectedOperateur = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // Numéro de débit
              const Text(
                "Numéro de débit",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                controller: _numeroDebitController,
                keyboardType: TextInputType.phone,
                maxLength: 15, // +225 + espace + 10 chiffres
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\+0-9 ]')),
                  LengthLimitingTextInputFormatter(15), // +225 + espace + 10 chiffres
                ],
                decoration: InputDecoration(
                  hintText: "Entrez le numéro de débit (+225)",
                  hintStyle: const TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.background),
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.phone,
                    color: AppColors.background,
                  ),
                ),
                onChanged: (value) {
                  if (!value.startsWith('+225 ')) {
                    _numeroDebitController.text = '+225 ';
                    _numeroDebitController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _numeroDebitController.text.length),
                    );
                  }
                },
              ),

              const SizedBox(height: 25),

              // Bouton Valider
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final numero = _numeroDebitController.text.replaceAll(' ', '');
                    String? errorMessage;

                    if (selectedCrypto == null) {
                      errorMessage = "Veuillez sélectionner une cryptomonnaie";
                    } else if (_montantController.text.isEmpty) {
                      errorMessage = "Veuillez entrer un montant en USD";
                    } else if (_cfaController.text.isEmpty) {
                      errorMessage = "Veuillez entrer un montant en CFA";
                    } else if (selectedOperateur == null) {
                      errorMessage = "Veuillez choisir un moyen de paiement";
                    } else if (numero.length != 14 || !numero.startsWith('+225')) {
                      errorMessage = "${numero.length}";
                    }


                    if (errorMessage != null) {
                      _showCupertinoDialog(context, errorMessage);
                    } else {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => const ProcessingScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Suivant",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// import 'package:abidjanexchange_mobile/widgets/operator_selector.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:abidjanexchange_mobile/utils/colors.dart';
// import 'package:abidjanexchange_mobile/widgets/cryptodropdown.dart';
// import 'package:flutter/services.dart';

// class AchatVenteScreen extends StatefulWidget {
//   const AchatVenteScreen({super.key});

//   @override
//   _AchatVenteScreenState createState() => _AchatVenteScreenState();
// }

// class _AchatVenteScreenState extends State<AchatVenteScreen> {
//   bool isAchat = true; // true = Achat, false = Vente
//   final TextEditingController _montantController = TextEditingController();
//   final TextEditingController _cfaController = TextEditingController();
//   final TextEditingController _numeroDebitController = TextEditingController();
//   String? selectedOperateur;
//   final double conversionRate = 613.0; // Taux de conversion : 1 USD = 613 CFA
//   bool _isUpdating = false; // Pour éviter les boucles infinies

//   final List<Map<String, dynamic>> operateurs = [
//     {"name": "Wave", "icon": "lib/images/logo.jpg"},
//     {"name": "Wave", "icon": "lib/images/logo.jpg"},
//     {"name": "Wave", "icon": "lib/images/logo.jpg"},
//     {"name": "Wave", "icon": "lib/images/logo.jpg"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Ajouter des listeners pour gérer les conversions bidirectionnelles
//     _montantController.addListener(_updateCfaFromUsd);
//     _cfaController.addListener(_updateUsdFromCfa);
//     // Pré-remplir l'indicatif +225
//     _numeroDebitController.text = "+225 ";
//   }

//   void _updateCfaFromUsd() {
//     if (_isUpdating) return; // Éviter les boucles infinies
//     _isUpdating = true;

//     if (_montantController.text.isNotEmpty) {
//       try {
//         final usd = double.parse(_montantController.text.replaceAll(',', '.'));
//         final cfa = usd * conversionRate;
//         setState(() {
//           _cfaController.text = cfa.toStringAsFixed(2);
//         });
//       } catch (e) {
//         setState(() {
//           _cfaController.text = '';
//         });
//       }
//     } else {
//       setState(() {
//         _cfaController.text = '';
//       });
//     }
//     _isUpdating = false;
//   }

//   void _updateUsdFromCfa() {
//     if (_isUpdating) return; // Éviter les boucles infinies
//     _isUpdating = true;

//     if (_cfaController.text.isNotEmpty) {
//       try {
//         final cfa = double.parse(_cfaController.text.replaceAll(',', '.'));
//         final usd = cfa / conversionRate;
//         setState(() {
//           _montantController.text = usd.toStringAsFixed(2);
//         });
//       } catch (e) {
//         setState(() {
//           _montantController.text = '';
//         });
//       }
//     } else {
//       setState(() {
//         _montantController.text = '';
//       });
//     }
//     _isUpdating = false;
//   }

//   @override
//   void dispose() {
//     _montantController.dispose();
//     _cfaController.dispose();
//     _numeroDebitController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.surface,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.surface,
//         leading: IconButton(
//           icon: const Icon(CupertinoIcons.back, color: AppColors.background),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Achat / Vente",
//           style: TextStyle(
//             color: AppColors.background,
//             fontWeight: FontWeight.bold,
//             fontSize: 23,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Toggle Achat / Vente
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => isAchat = true),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           decoration: BoxDecoration(
//                             color: isAchat ? AppColors.primary : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               "Acheter",
//                               style: TextStyle(
//                                 color: AppColors.background,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => isAchat = false),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           decoration: BoxDecoration(
//                             color: !isAchat ? AppColors.primary : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               "Vendre",
//                               style: TextStyle(
//                                 color: AppColors.background,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // Choix Crypto
//               const Text(
//                 "Choisissez la cryptomonnaie",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const CryptoSelectorInput(),

//               const SizedBox(height: 25),

//               // Montant en dollars
//               const Text(
//                 "Montant en USD",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                 controller: _montantController,
//                 keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                 decoration: InputDecoration(
//                   hintText: "Entrez le montant en USD",
//                   hintStyle: const TextStyle(
//                     color: AppColors.background,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade200,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: AppColors.background),
//                   ),
//                   prefixIcon: const Icon(
//                     CupertinoIcons.money_dollar,
//                     color: AppColors.background,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // Montant en CFA
//               const Text(
//                 "Montant en CFA",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                 controller: _cfaController,
//                 keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                 decoration: InputDecoration(
//                   hintText: "Montant en CFA",
//                   hintStyle: const TextStyle(
//                     color: AppColors.background,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade200,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: AppColors.background),
//                   ),
//                   prefixIcon: const Icon(
//                     CupertinoIcons.money_dollar,
//                     color: AppColors.background,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // Moyen de paiement
//               const Text(
//                 "Choisissez le moyen de paiement",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               OperateurSelectorInput(
               
//               ),

//               const SizedBox(height: 25),

//               // Numéro de débit
//               const Text(
//                 "Numéro de débit",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                 controller: _numeroDebitController,
//                 keyboardType: TextInputType.phone,
//                 maxLength: 15, // +225 + espace + 10 chiffres
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[\+0-9 ]')),
//                   LengthLimitingTextInputFormatter(15), // +225 + espace + 10 chiffres
//                 ],
//                 decoration: InputDecoration(
//                   hintText: "Entrez le numéro de débit (+225)",
//                   hintStyle: const TextStyle(
//                     color: AppColors.background,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade200,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: AppColors.background),
//                   ),
//                   prefixIcon: const Icon(
//                     CupertinoIcons.phone,
//                     color: AppColors.background,
//                   ),
//                 ),
//                 onChanged: (value) {
//                   if (!value.startsWith('+225 ')) {
//                     _numeroDebitController.text = '+225 ';
//                     _numeroDebitController.selection = TextSelection.fromPosition(
//                       TextPosition(offset: _numeroDebitController.text.length),
//                     );
//                   }
//                 },
//               ),

//               const SizedBox(height: 25),

//               // Bouton Valider
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     final numero = _numeroDebitController.text.replaceAll(' ', '');
//                     if (_montantController.text.isEmpty ||
//                         _cfaController.text.isEmpty ||
//                         selectedOperateur == null ||
//                         numero.length != 13 || // +225 + 10 chiffres
//                         !numero.startsWith('+225')) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Veuillez remplir tous les champs correctement")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             "${isAchat ? "Achat" : "Vente"} de ${_montantController.text} USD (${_cfaController.text} CFA) via $selectedOperateur avec le numéro $numero en cours...",
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Suivant",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }