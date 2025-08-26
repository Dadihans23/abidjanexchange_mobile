import 'package:abidjanexchange_mobile/screens/buyin_trait.dart';
import 'package:abidjanexchange_mobile/widgets/custom_header_appbar.dart';
import 'package:abidjanexchange_mobile/widgets/operator_selector.dart';
import 'package:abidjanexchange_mobile/widgets/ops.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/widgets/cryptodropdown.dart';
import 'package:flutter/services.dart';

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
//   String? selectedCrypto; // Pour stocker la cryptomonnaie sélectionnée
//   final double conversionRate = 613.0; // Taux de conversion : 1 USD = 613 CFA
//   bool _isUpdating = false; // Pour éviter les boucles infinies

//    bool isDarkMode = false; // état pour le mode nuit
//   bool isNotificationOn = false; // état pour la notification


//   double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;


// final List<Map<String, String>> operateurs3 = [
//     {"name": "Wave", "icon": "lib/images/wavelogo.jpg" , "fee": "1.5 %"},
//     {"name": "Orange", "icon": "lib/images/orangelogo.jpg" , "fee": "2 %"},
//     {"name": "Moov", "icon": "lib/images/moovlogo.png" , "fee": "1.8 %"},

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

//   void _showCupertinoDialog(BuildContext context, String message) {
//     showCupertinoDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoAlertDialog(
//           title: const Text("Alerte", style: TextStyle(color: AppColors.textPrimary)),
//           content: Text(message, style: const TextStyle(color: AppColors.textSecondary)),
//           actions: <Widget>[
//             CupertinoDialogAction(
//               child: Text("Okay", style: TextStyle(color: AppColors.primary)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
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

//     final width = screenWidth(context);
//     return Scaffold(
//       backgroundColor: AppColors.surface,
      
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Container(
//           padding: const EdgeInsets.all(00),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10,),
//               Container(
//                 color: Colors.indigoAccent,
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Logo + Titre
//                     Row(
//                       children: [
//                         Container(
//                             margin: const EdgeInsets.all(8),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.3),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.arrow_back_ios,
//                               color: Colors.white,
//                               size: width * 0.08,
//                             ),
//                           ),
//                         const SizedBox(width: 8),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Acheter crypto",
//                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             Text(
//                               "Acheter facilement",
//                               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     // Icônes actions
                    
//                   ],
//                 ),
//               ),
             
              

//               const SizedBox(height: 25),
//               Container(
//                 padding: EdgeInsetsDirectional.symmetric(horizontal: 20 , vertical:02),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Choix Crypto
//               const Text(
//                 " Crypto-monnaie",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               CryptoSelectorInput(
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCrypto = value;
//                   });
//                 },
//               ),

//               const SizedBox(height: 25),


//               const Text(
//                 "Montant en CFA",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
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

//               // Montant en dollars
//               const Text(
//                 "Montant en USD",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
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
              
//               const SizedBox(height: 25),

//               // Moyen de paiement
//               const Text(
//                 "Paimement",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.background,
//                 ),
//               ),

//              OperateurSelector(
//               operateurs: operateurs3,
//               onSelected: (op) {
//                 setState(() {
//                   selectedOperateur = op['name']; // On sauvegarde le choix
//                 });
//                 print("Opérateur choisi: ${op['name']}");
//               },
//             ) ,






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

//               const Text(
//                 "Adresse d'envoi",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.background,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                 controller: _montantController,
//                 keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                 decoration: InputDecoration(
//                   hintText: "Generation automatique ",
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

//                // Bouton Valider
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     final numero = _numeroDebitController.text.replaceAll(' ', '');
//                     String? errorMessage;

//                     if (selectedCrypto == null) {
//                       errorMessage = "Veuillez sélectionner une cryptomonnaie";
//                     } else if (_montantController.text.isEmpty) {
//                       errorMessage = "Veuillez entrer un montant en USD";
//                     } else if (_cfaController.text.isEmpty) {
//                       errorMessage = "Veuillez entrer un montant en CFA";
//                     } else if (selectedOperateur == null) {
//                       errorMessage = "Veuillez choisir un moyen de paiement";
//                     } else if (numero.length != 14 || !numero.startsWith('+225')) {
//                       errorMessage = "${numero.length}";
//                     }


//                     if (errorMessage != null) {
//                       _showCupertinoDialog(context, errorMessage);
//                     } else {
                      
//                       Navigator.push(
//                         context,
//                         CupertinoPageRoute(builder: (context) => const ProcessingScreen()),
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

//                   ],
//                 ),
//               ) ,

              
             
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









import 'package:abidjanexchange_mobile/widgets/operator_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/widgets/cryptodropdown.dart';
import 'package:flutter/services.dart';
import 'dart:math'; // Pour générer une adresse aléatoire

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
  final TextEditingController _adresseController = TextEditingController(); // Nouveau contrôleur pour l'adresse
  String? selectedOperateur;
  String? selectedCrypto; // Pour stocker la cryptomonnaie sélectionnée
  final double conversionRate = 613.0; // Taux de conversion : 1 USD = 613 CFA
  bool _isUpdating = false; // Pour éviter les boucles infinies

  bool isDarkMode = false; // état pour le mode nuit
  bool isNotificationOn = false; // état pour la notification

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final List<Map<String, String>> operateurs3 = [
    {"name": "Wave", "icon": "lib/images/wavelogo.jpg", "fee": "1.5 %"},
    {"name": "Orange", "icon": "lib/images/orangelogo.jpg", "fee": "2 %"},
    {"name": "Moov", "icon": "lib/images/moovlogo.png", "fee": "1.8 %"},
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

  // Générer une adresse aléatoire (simulant une adresse crypto, ex: Ethereum)
  void _generateRandomAddress() {
    const String chars = '0123456789abcdef';
    final Random random = Random();
    String address = '0x';
    for (int i = 0; i < 40; i++) {
      address += chars[random.nextInt(chars.length)];
    }
    setState(() {
      _adresseController.text = address;
    });
  }

  // Copier l'adresse dans le presse-papiers
  void _copyAddressToClipboard() {
    if (_adresseController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _adresseController.text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Adresse copiée dans le presse-papiers"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _showCupertinoDialog(context, "Aucune adresse à copier");
    }
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
    _adresseController.dispose(); // Disposer du nouveau contrôleur
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = screenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                color: Colors.indigoAccent,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo + Titre
                    Row(
                      children: [
                       GestureDetector(
  onTap: () {
    Navigator.pop(context); // Revient en arrière
  },
  child: Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.3),
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
      size: width * 0.08,
    ),
  ),
),

                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Acheter crypto",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "Acheter facilement",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Choix Crypto
                    const Text(
                      "Crypto-monnaie",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
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
                    // Montant en CFA
                    const Text(
                      "Montant en CFA",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
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
                    // Montant en dollars
                    const Text(
                      "Montant en USD",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
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
                    // Moyen de paiement
                    const Text(
                      "Paiement",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.background,
                      ),
                    ),
                    OperateurSelector(
                      operateurs: operateurs3,
                      onSelected: (op) {
                        setState(() {
                          selectedOperateur = op['name']; // On sauvegarde le choix
                        });
                        print("Opérateur choisi: ${op['name']}");
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
                      maxLength: 14, // +225 + espace + 10 chiffres
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\+0-9 ]')),
                        LengthLimitingTextInputFormatter(14), // +225 + espace + 10 chiffres
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
                    // Adresse d'envoi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Adresse d'envoi",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.background,
                          ),
                        ),
                        TextButton(
                          onPressed: _generateRandomAddress,
                          child: const Text(
                            "Générer",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      controller: _adresseController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Adresse de réception",
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
                          CupertinoIcons.lock,
                          color: AppColors.background,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            CupertinoIcons.doc_on_clipboard,
                            color: AppColors.background,
                          ),
                          onPressed: _copyAddressToClipboard,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Bouton Suivant
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
                          } else if (numero.length != 13 || !numero.startsWith('+225')) {
                            errorMessage = "Veuillez entrer un numéro de débit valide (+225 suivi de 10 chiffres)";
                          } else if (_adresseController.text.isEmpty) {
                            errorMessage = "Veuillez entrer ou générer une adresse d'envoi";
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
            ],
          ),
        ),
      ),
    );
  }
}