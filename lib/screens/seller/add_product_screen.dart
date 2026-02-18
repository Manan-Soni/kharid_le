import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _marginController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _costPriceController.addListener(_calculateMargin);
    _sellingPriceController.addListener(_calculateMargin);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    _marginController.dispose();
    super.dispose();
  }

  void _calculateMargin() {
    if (_costPriceController.text.isNotEmpty && _sellingPriceController.text.isNotEmpty) {
      double cost = double.tryParse(_costPriceController.text) ?? 0;
      double selling = double.tryParse(_sellingPriceController.text) ?? 0;
      
      if (cost > 0 && selling > 0) {
        // Assuming Profit Margin = ((Selling - Cost) / Selling) * 100 for retail margin
        // Or if standard markup: ((Selling - Cost) / Cost) * 100
        // Let's use standard margin ((SP-CP)/SP)*100 as it's common in retail.
        // Or simpler ((SP - CP) / CP) * 100 which is markup. 
        // Let's stick to ((Selling - Cost) / Selling) * 100 which is Gross Margin.
        double margin = ((selling - cost) / selling) * 100;
        _marginController.text = margin.toStringAsFixed(2);
      } else {
        _marginController.text = '';
      }
    } else {
      _marginController.text = '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel('Product Photo (Optional)'),
              const SizedBox(height: 8),
              _buildPhotoUploadArea(),
              const SizedBox(height: 20),
              
              _buildSectionLabel('Product Name'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _nameController,
                hintText: 'e.g., Premium Basmati Rice 5kg',
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('SKU / Variant'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _skuController,
                hintText: 'e.g., RICE-5KG-001',
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Date Purchased'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _formatDate(_selectedDate),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Pricing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              _buildSectionLabel('Cost Price (₹)'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _costPriceController,
                hintText: '0',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildSectionLabel('Selling Price (₹)'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _sellingPriceController,
                hintText: '0',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildSectionLabel('Profit Margin (%)'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _marginController,
                hintText: '0',
                keyboardType: TextInputType.number,
                readOnly: true, // Auto-calculated
              ),
              
              const SizedBox(height: 80), // Bottom padding for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Validate and save
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        },
        backgroundColor: const Color(0xFF1A73E8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 1.5),
        ),
        filled: true,
        fillColor: readOnly ? Colors.grey[50] : Colors.white,
      ),
      validator: (value) {
        if (!readOnly && (value == null || value.isEmpty)) {
          return 'Please enter value';
        }
        return null;
      },
    );
  }

  Widget _buildPhotoUploadArea() {
    return InkWell(
      onTap: () {
        // Implement image picker
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[50], // Very light grey background
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid, // Dotted border is complex in Flutter without packages or custom painter, using solid light border like modern inputs often do, or could use DottedBorder package if available. 
            // Since DottedBorder is external package, I will simulate with standard border.
          ),
        ),
        // To strictly match dotted border, we'd need CustomPainter. 
        // For now, standard border with light background is good.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'Tap to upload photo',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
