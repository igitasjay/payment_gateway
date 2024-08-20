import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payment_gateway/failure.dart';
import 'package:payment_gateway/secret.dart';
import 'package:payment_gateway/success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({super.key});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;
  TextEditingController controller = TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': Secret.apiKey,
      'amount': amount,
      'name': 'Jay Jay',
      'prefill': {'contact': '09023143443', 'email': 'mymailer@gmail.com'},
      'external': {
        'wallets': ['paytm'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Success(message: response.paymentId!),
      ),
    );
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Failure(message: response.message!),
      ),
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Wallet name: ${response.walletName!}");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bakery_dining_rounded,
              size: MediaQuery.of(context).size.width / 4,
              color: Colors.deepPurple.shade800,
            ),
            const Text(
              "Razorpay Gateway",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                label: const Text("enter amount to send"),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "enter amount jhor";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (controller.text.toString().isNotEmpty) {
                    setState(() {
                      int amount = int.parse(controller.text);
                      openCheckout(amount);
                    });
                  }
                },
                child: const Text("Pay"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
