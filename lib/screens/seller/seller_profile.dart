import 'package:flutter/material.dart';

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2E6FF2);
    const Color backgroundColor = Color(0xFFF4F5F9);
    const Color cardBorderColor = Color(0xFFE2E3EA);
    const Color sectionLabelColor = Color(0xFF8B8E9A);
    const Color titleColor = Color(0xFF151827);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                'Profile',
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
                    const _BusinessHeaderCard(),
                    const SizedBox(height: 20),
                    const _SectionCard(
                      label: 'BUSINESS',
                      items: [
                        _SectionItemData(title: 'Edit Business Details'),
                        _SectionItemData(title: 'Analytics & Reports'),
                        _SectionItemData(title: 'Subscription Plan'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const _SectionCard(
                      label: 'SETTINGS',
                      items: [
                        _SectionItemData(title: 'Notification Preferences'),
                        _SectionItemData(title: 'App Preferences'),
                        _SectionItemData(title: 'Language Selection'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const _SectionCard(
                      label: 'SUPPORT',
                      items: [
                        _SectionItemData(title: 'Help & Support'),
                        _SectionItemData(
                          title: 'Logout',
                          isDestructive: true,
                        ),
                      ],
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

class _BusinessHeaderCard extends StatelessWidget {
  const _BusinessHeaderCard();

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2E6FF2);
    const Color cardBorderColor = Color(0xFFE2E3EA);
    const Color titleColor = Color(0xFF151827);
    const Color subtitleColor = Color(0xFF6E717C);

    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Sharma General Store',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Rajesh Sharma',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: subtitleColor,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color: subtitleColor,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '+91 98765 43210',
                      style: TextStyle(
                        fontSize: 13,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: subtitleColor,
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Karol Bagh, New Delhi',
                        style: TextStyle(
                          fontSize: 13,
                          color: subtitleColor,
                        ),
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

class _SectionCard extends StatelessWidget {
  final String label;
  final List<_SectionItemData> items;

  const _SectionCard({
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    const Color sectionLabelColor = Color(0xFF8B8E9A);
    const Color cardBorderColor = Color(0xFFE2E3EA);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7,
              color: sectionLabelColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardBorderColor),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                _SectionListTile(data: items[i]),
                if (i != items.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 0.7,
                    color: Color(0xFFE8E9F0),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionItemData {
  final String title;
  final bool isDestructive;

  const _SectionItemData({
    required this.title,
    this.isDestructive = false,
  });
}

class _SectionListTile extends StatelessWidget {
  final _SectionItemData data;

  const _SectionListTile({required this.data});

  @override
  Widget build(BuildContext context) {
    const Color titleColor = Color(0xFF151827);
    const Color destructiveColor = Color(0xFFE54848);

    return InkWell(
      onTap: () {
        // TODO: hook up navigation or actions.
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                data.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: data.isDestructive ? destructiveColor : titleColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: data.isDestructive ? destructiveColor : const Color(0xFFB3B6C2),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

