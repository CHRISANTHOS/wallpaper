import 'dart:io';
import 'package:wallpaper/constants/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpaper/utils/snackbar.dart';
import 'package:wallpaper/provider/purchased_wallpaper.dart';

class Payment{
  String image;
  BuildContext context;
  String amount;

  Payment({required this.context, required this.amount, required this.image});

  User? user = FirebaseAuth.instance.currentUser;

  PaystackPlugin paystackPlugin = PaystackPlugin();

  String? platform;

  String _getReference(){
    if(Platform.isIOS){
      platform = 'IOS';
    }else{
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().microsecondsSinceEpoch}';
  }

  PaymentCard getCardFromUI(){
    return PaymentCard(number: '', cvc: '', expiryMonth: 0, expiryYear: 0, country: '', name: user!.displayName);
  }

  Future initializePlugin()async{
    await paystackPlugin.initialize(publicKey: Keys.PUBLIC_KEY);
  }

  chargeCardAndMakePayment()async{
    final String price = amount.replaceAll(',', '');
    initializePlugin().then((_) async{
      Charge charge = Charge()
          ..amount = int.parse(price) * 100
          ..email = user!.email
          ..currency = 'NGN'
          ..reference = _getReference()
          ..card = getCardFromUI();

      CheckoutResponse response = await paystackPlugin.checkout(context, charge: charge, method: CheckoutMethod.card, fullscreen:  false);

      final String message = response.message;

      if(response.status == true){
        PurchasedWallPaper().save(wallpaperImage: image);
      }else{
        showSnackBar(context, message);
      }
    });
  }

}