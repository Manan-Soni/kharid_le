import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, dynamic>> savedDeals = [
    {
      'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1000&auto=format&fit=crop',
      'title': 'Premium Basmati Rice 5kg',
      'store': 'Krishna Stores',
      'distance': '1.2 km',
      'price': '680',
      'originalPrice': '850',
      'discount': '20% OFF',
      'validUntil': '28 Feb 2026',
    },
    {
      'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?q=80&w=1000&auto=format&fit=crop',
      'title': 'Wireless Earbuds Pro',
      'store': 'Tech World',
      'distance': '2.1 km',
      'price': '1750',
      'originalPrice': '2500',
      'discount': '30% OFF',
      'validUntil': '1 Mar 2026',
    },
    {
      'image': 'https://images.unsplash.com/photo-1611080626919-7cf5a9caab53?q=80&w=1000&auto=format&fit=crop',
      'title': 'Gold Plated Necklace',
      'store': 'Royal Jewels',
      'distance': '1.5 km',
      'price': '3200',
      'originalPrice': '4000',
      'discount': '20% OFF',
      'validUntil': '5 Mar 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF5900b3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Saved Deals',
          style: TextStyle(
            color: Color(0xFF1A1C2E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Summary Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F7FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFD1E1FF)),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${savedDeals.length}',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        const Text(
                          'Saved Deals',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹2220',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Total Savings',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Tip Box
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFEAB0)),
                ),
                padding: const EdgeInsets.all(16),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Color(0xFF856404), fontSize: 13, height: 1.4),
                    children: [
                      TextSpan(
                        text: 'Tip: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Some deals are expiring soon! Visit stores before the deadline.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Saved Deals List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: savedDeals.length,
                itemBuilder: (context, index) {
                  final deal = savedDeals[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE8ECF4)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  deal['image'],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF4D9),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        deal['discount'],
                                        style: const TextStyle(
                                          color: Color(0xFFD4A017),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      deal['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF1A1C2E),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF8391A1)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${deal['store']} • ${deal['distance']}',
                                          style: const TextStyle(
                                            color: Color(0xFF8391A1),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          '₹${deal['price']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color(0xFF1A1C2E),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '₹${deal['originalPrice']}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            color: Color(0xFF8391A1),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Valid until ${deal['validUntil']}',
                                      style: const TextStyle(
                                        color: Color(0xFF8391A1),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: Color(0xFFE8ECF4)),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.open_in_new, size: 18),
                                label: const Text('View Deal'),
                                style: TextButton.styleFrom(
                                  foregroundColor: primaryColor,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            Container(width: 1, height: 40, color: const Color(0xFFE8ECF4)),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    savedDeals.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete_outline, size: 18),
                                label: const Text('Remove'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
