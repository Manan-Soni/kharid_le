import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../services/product_service.dart';
import '../../models/product_model.dart';

const Color _primaryColor = Color(0xFF2E6FF2);
const Color _backgroundColor = Color(0xFFF4F5F9);
const Color _titleColor = Color(0xFF151827);
const Color _subtitleColor = Color(0xFF6E717C);
const Color _cardBorderColor = Color(0xFFE2E3EA);

class SellerAddProductScreen extends StatefulWidget {
  const SellerAddProductScreen({super.key});

  @override
  State<SellerAddProductScreen> createState() => _SellerAddProductScreenState();
}

class _SellerAddProductScreenState extends State<SellerAddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _marginController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  String _selectedCategory = 'Grocery';

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _dateController.text = DateFormat('dd MMM yyyy').format(today);
    _qtyController.text = '1';
    _costPriceController.addListener(_recalculateFromCostOrSelling);
    _sellingPriceController.addListener(_recalculateFromCostOrSelling);
    _marginController.addListener(_recalculateFromMargin);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _dateController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    _marginController.dispose();
    _qtyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  double get _costPrice => double.tryParse(_costPriceController.text) ?? 0;
  double get _sellingPrice => double.tryParse(_sellingPriceController.text) ?? 0;
  double get _margin => double.tryParse(_marginController.text) ?? 0;

  double get _profitPerUnit => _sellingPrice - _costPrice;

  void _recalculateFromCostOrSelling() {
    final cp = _costPrice;
    final sp = _sellingPrice;
    if (cp > 0 && sp >= 0) {
      final margin = cp == 0 ? 0 : ((sp - cp) / cp) * 100;
      _marginController.removeListener(_recalculateFromMargin);
      _marginController.text =
          margin.isFinite ? margin.toStringAsFixed(1) : '0';
      _marginController.addListener(_recalculateFromMargin);
      setState(() {});
    }
  }

  void _recalculateFromMargin() {
    final cp = _costPrice;
    final m = _margin;
    if (cp >= 0) {
      final sp = cp * (1 + m / 100);
      _sellingPriceController.removeListener(_recalculateFromCostOrSelling);
      _sellingPriceController.text =
          sp.isFinite ? sp.toStringAsFixed(2) : _sellingPriceController.text;
      _sellingPriceController.addListener(_recalculateFromCostOrSelling);
      setState(() {});
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      _dateController.text = DateFormat('dd MMM yyyy').format(picked);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Product',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _titleColor,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionCard(
                      title: 'Basic Information',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Photo (Optional)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _subtitleColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _LabeledTextField(
                            label: 'Image URL',
                            controller: _imageUrlController,
                            hintText: 'https://example.com/product.jpg',
                          ),
                          const SizedBox(height: 16),
                          _LabeledTextField(
                            label: 'Product Name',
                            controller: _nameController,
                            hintText: 'Enter product name',
                          ),
                          const SizedBox(height: 12),
                          _LabeledTextField(
                            label: 'SKU / Variant',
                            controller: _skuController,
                            hintText: 'Enter SKU or variant',
                          ),
                          const SizedBox(height: 12),
                          _LabeledTextField(
                            label: 'Date Purchased',
                            controller: _dateController,
                            readOnly: true,
                            onTap: _pickDate,
                            hintText: 'Select purchase date',
                            suffixIcon: const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: _subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      title: 'Pricing',
                      child: Column(
                        children: [
                          _LabeledTextField(
                            label: 'Cost Price (₹)',
                            controller: _costPriceController,
                            keyboardType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            hintText: '0.00',
                          ),
                          const SizedBox(height: 12),
                          _LabeledTextField(
                            label: 'Selling Price (₹)',
                            controller: _sellingPriceController,
                            keyboardType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            hintText: '0.00',
                          ),
                          const SizedBox(height: 12),
                          _LabeledTextField(
                            label: 'Profit Margin (%)',
                            controller: _marginController,
                            keyboardType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            hintText: '0',
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7FB),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Estimated Profit',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _subtitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '₹${_profitPerUnit.toStringAsFixed(2)} per unit',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: _titleColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      title: 'Inventory',
                      child: _LabeledTextField(
                        label: 'Quantity',
                        controller: _qtyController,
                        keyboardType: TextInputType.number,
                        hintText: '0',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      title: 'Classification',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _subtitleColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _cardBorderColor),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: _subtitleColor,
                                ),
                                items: const [
                                  'Grocery',
                                  'Apparel',
                                  'Electronics',
                                  'Handmade',
                                  'Custom',
                                  'Add New Category',
                                ].map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: _titleColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    _selectedCategory = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: _saveProduct,
            child: const Text('Save Product'),
          ),
        ),
      ),
    );
  }

  void _saveProduct() async {
    final name = _nameController.text.trim();
    final costPrice = double.tryParse(_costPriceController.text) ?? 0;
    final sellingPrice = double.tryParse(_sellingPriceController.text) ?? 0;
    final quantity = int.tryParse(_qtyController.text) ?? 0;

    if (name.isEmpty || costPrice <= 0 || sellingPrice <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    final user = auth.currentUser;

    if (user == null) return;

    final product = ProductModel(
      id: '', // Will be generated by Firestore
      name: name,
      category: _selectedCategory,
      price: sellingPrice,
      costPrice: costPrice,
      quantity: quantity,
      sellerId: user.id,
      sellerName: user.shopName ?? user.name,
      location: const GeoPoint(28.6448, 77.2167), // Default to New Delhi if unknown
      sku: _skuController.text.trim(),
      purchaseDate: DateFormat('dd MMM yyyy').parse(_dateController.text),
      imageURL: _imageUrlController.text.trim().isNotEmpty 
          ? _imageUrlController.text.trim() 
          : null,
    );

    try {
      await ProductService().addProduct(product);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding product: $e')),
        );
      }
    }
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7,
              color: _subtitleColor,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _cardBorderColor),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final Widget? suffixIcon;

  const _LabeledTextField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _subtitleColor,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: _subtitleColor,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _cardBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primaryColor),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}


