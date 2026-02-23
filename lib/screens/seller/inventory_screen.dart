import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xFF2E6FF2);

class SellerInventoryScreen extends StatelessWidget {
  const SellerInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF4F5F9);
    const Color titleColor = Color(0xFF151827);
    const Color subtitleColor = Color(0xFF6E717C);
    const Color cardBorderColor = Color(0xFFE2E3EA);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top app bar title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                'Inventory',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Inventory Health card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: cardBorderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Inventory Health',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: titleColor,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Slow: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: subtitleColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '12',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: titleColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '   ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      TextSpan(
                                        text: 'Critical: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: subtitleColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '6',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: titleColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            '68/100',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: _primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Search field
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: const TextStyle(
                          color: subtitleColor,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: subtitleColor,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: cardBorderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: _primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Category chips row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          _FilterChipPill(label: 'All', isSelected: true),
                          _FilterChipPill(label: 'Grocery'),
                          _FilterChipPill(label: 'Apparel'),
                          _FilterChipPill(label: 'Electronics'),
                          _FilterChipPill(label: 'Handmade'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Status chips row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          _FilterChipPill(label: 'All', isSelected: true),
                          _FilterChipPill(label: 'Slow'),
                          _FilterChipPill(label: 'Critical'),
                          _FilterChipPill(label: 'Good'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sample inventory items
                    const _InventoryItemCard(
                      imageColor: Color(0xFFF5D6A4),
                      name: 'Premium Handloom Saree',
                      category: 'Grocery',
                      quantity: 18,
                      price: '₹8,400',
                      statusLabel: 'CRITICAL',
                      statusColor: Color(0xFFE54848),
                      blockedDays: 45,
                    ),
                    const SizedBox(height: 12),
                    const _InventoryItemCard(
                      imageColor: Color(0xFFF1C8D5),
                      name: 'Cotton Casual Kurti',
                      category: 'Apparel',
                      quantity: 12,
                      price: '₹5,400',
                      statusLabel: 'SLOW',
                      statusColor: Color(0xFFF6A623),
                      blockedDays: 38,
                    ),
                    const SizedBox(height: 12),
                    const _InventoryItemCard(
                      imageColor: Color(0xFFD4E3F9),
                      name: 'Wireless Earbuds',
                      category: 'Electronics',
                      quantity: 8,
                      price: '₹12,000',
                      statusLabel: 'CRITICAL',
                      statusColor: Color(0xFFE54848),
                      blockedDays: 52,
                    ),
                    const SizedBox(height: 12),
                    const _InventoryItemCard(
                      imageColor: Color(0xFFF9E3C7),
                      name: 'Handwoven Basket Set',
                      category: 'Handmade',
                      quantity: 25,
                      price: '₹6,250',
                      statusLabel: 'SLOW',
                      statusColor: Color(0xFFF6A623),
                      blockedDays: 28,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChipPill extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChipPill({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color(0xFFE0E1E9);
    const Color textColor = Color(0xFF151827);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _primaryColor : borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : textColor,
          ),
        ),
      ),
    );
  }
}

class _InventoryItemCard extends StatelessWidget {
  final Color imageColor;
  final String name;
  final String category;
  final int quantity;
  final String price;
  final String statusLabel;
  final Color statusColor;
  final int blockedDays;

  const _InventoryItemCard({
    required this.imageColor,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.statusLabel,
    required this.statusColor,
    required this.blockedDays,
  });

  @override
  Widget build(BuildContext context) {
    const Color cardBorderColor = Color(0xFFE2E3EA);
    const Color titleColor = Color(0xFF151827);
    const Color subtitleColor = Color(0xFF6E717C);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder product image
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF0FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2E6FF2),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  statusLabel,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Manage button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: _primaryColor,
                            elevation: 0,
                            side: const BorderSide(
                              color: Color(0xFFE2E3EA),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            // TODO: hook up manage action.
                          },
                          child: const Text('Manage'),
                        ),
                        const SizedBox(height: 8),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: Color(0xFFB3B6C2),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Qty: $quantity',
                      style: const TextStyle(
                        fontSize: 12,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${blockedDays}d',
                      style: const TextStyle(
                        fontSize: 12,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

