import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_scaffold.dart';
import 'payment_success_screen.dart';

class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  // Input Controllers initialized with values from the design image
  final TextEditingController _cardNumberController =
      TextEditingController(text: "4242  4242  4242  4242");
  final TextEditingController _expiryDateController =
      TextEditingController(text: "12/28");
  final TextEditingController _cvvController =
      TextEditingController(text: "123");
  final TextEditingController _cardholderController =
      TextEditingController(text: "Kathy Onana");

  // Currency Selection State
  String _selectedCurrency = 'USD';
  final List<String> _currencies = ['USD', 'EUR', 'FCFA'];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardholderController.dispose();
    super.dispose();
  }

  // Get formatted amount based on selected currency
  String _getFormattedAmount() {
    if (_selectedCurrency == 'USD') {
      return '\$35.00';
    } else if (_selectedCurrency == 'EUR') {
      return '€35.00';
    } else {
      return '35.00 FCFA';
    }
  }

  // Get dynamic button text
  String _getButtonText() {
    if (_selectedCurrency == 'USD') {
      return 'Pay \$35.00';
    } else if (_selectedCurrency == 'EUR') {
      return 'Pay €35.00';
    } else {
      return 'Pay 35.00 FCFA';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF0F172A),
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          "Card Payment",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Section Title
                  const Text(
                    "Enter Amount",
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Amount Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(6),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Currency Amount
                        Text(
                          _getFormattedAmount(),
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Currency Selector Pill
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCECEDF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: _currencies.map((currency) {
                              final isSelected = _selectedCurrency == currency;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCurrency = currency;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: Colors.black.withAlpha(12),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    currency,
                                    style: TextStyle(
                                      color: isSelected
                                          ? const Color(0xFF0F172A)
                                          : Colors.white.withAlpha(220),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Card Information Group Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FB),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Card Information",
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Card Number Field
                        _buildCardField(
                          icon: _buildCardIcon(),
                          label: "Card Number",
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardNumberFormatter(),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Expiry Date and CVV Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardField(
                                icon: _buildCalendarIcon(),
                                label: "Expiry Date",
                                controller: _expiryDateController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ExpiryDateFormatter(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildCardField(
                                icon: _buildCVVIcon(),
                                label: "CVV",
                                controller: _cvvController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Cardholder Name Field
                        _buildCardField(
                          icon: _buildCardholderIcon(),
                          label: "Cardholder Name",
                          controller: _cardholderController,
                          keyboardType: TextInputType.name,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => PaymentSuccessScreen(
                              amount: _getFormattedAmount(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5151EF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _getButtonText(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper widget to construct the text field cards exactly as in the mock
  Widget _buildCardField({
    required Widget icon,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 36,
            alignment: Alignment.centerLeft,
            child: icon,
          ),
          const SizedBox(width: 8),

          // Label and Interactive TextFormField
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Vector-like custom credit card outline icon
  Widget _buildCardIcon() {
    return Container(
      width: 28,
      height: 18,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0F172A), width: 1.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 3,
            bottom: 3,
            child: Container(
              width: 5,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Vector-like custom calendar outline icon
  Widget _buildCalendarIcon() {
    return SizedBox(
      width: 28,
      height: 20,
      child: Stack(
        children: [
          // Main Body
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0F172A), width: 1.5),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                children: [
                  Container(
                    height: 3,
                    color: const Color(0xFF0F172A),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDot(),
                      _buildDot(),
                      _buildDot(),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDot(),
                      _buildDot(),
                      _buildDot(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Ring loops on top
          Positioned(
            top: 0,
            left: 6,
            child: Container(
              width: 1.5,
              height: 5,
              color: const Color(0xFF0F172A),
            ),
          ),
          Positioned(
            top: 0,
            right: 6,
            child: Container(
              width: 1.5,
              height: 5,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 1.5,
      height: 1.5,
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        shape: BoxShape.circle,
      ),
    );
  }

  // Vector-like custom CVV outline card icon
  Widget _buildCVVIcon() {
    return Container(
      width: 28,
      height: 18,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0F172A), width: 1.5),
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 0.5),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(1),
        ),
        child: const Text(
          "CVV",
          style: TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }

  // Vector-like custom cardholder pocket/badge icon
  Widget _buildCardholderIcon() {
    return Container(
      width: 28,
      height: 18,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0F172A), width: 1.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 3,
            left: 0,
            right: 0,
            child: Container(
              height: 1.5,
              color: const Color(0xFF0F172A),
            ),
          ),
          Positioned(
            top: 7,
            left: 5,
            right: 5,
            bottom: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0F172A), width: 1),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper formatting inputters for credit cards and dates
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' ', '');
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && (i + 1) != text.length) {
        buffer.write('  '); // Double space like image
      }
    }

    var string = buffer.toString();
    return TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
