import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 24),
            _buildSectionHeader('BUSINESS'),
            _buildMenuCard([
              _buildMenuItem('Edit Business Details', onTap: () {}),
              _buildDivider(),
              _buildMenuItem('Analytics & Reports', onTap: () {}),
              _buildDivider(),
              _buildMenuItem('Subscription Plan', onTap: () {}),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('SETTINGS'),
            _buildMenuCard([
              _buildMenuItem('Notification Preferences', onTap: () {}),
              _buildDivider(),
              _buildMenuItem('App Preferences', onTap: () {}),
              _buildDivider(),
              _buildMenuItem('Language Selection', onTap: () {}),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('SUPPORT'),
            _buildMenuCard([
              _buildMenuItem('Help & Support', onTap: () {}),
              _buildDivider(),
              _buildMenuItem(
                'Logout',
                textColor: Colors.red,
                onTap: () {
                  // Handle logout
                },
              ),
            ]),
            const SizedBox(height: 30), // Bottom spacing
          ],
        ),
      ),
      // Bottom navigation bar would typically be handled by a main layout wrapper,
      // but if this screen is standalone or part of a indexed stack, it's fine.
      // The image shows a bottom nav, but usually that's parent to the body.
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1A73E8), // Google Blue-ish
              ),
              child: const Icon(
                Icons.store,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sharma General Store',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildProfileInfoRow(Icons.person_outline, 'Rajesh Sharma'),
                  const SizedBox(height: 4),
                  _buildProfileInfoRow(Icons.phone_outlined, '+91 98765 43210'),
                  const SizedBox(height: 4),
                  _buildProfileInfoRow(Icons.location_on_outlined, 'Karol Bagh, New Delhi'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Card(
      elevation: 0, // Mockup looks flat or very low elevation, mostly outlined or just background diff
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white,
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem(String title, {Color? textColor, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
        size: 20,
      ),
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(vertical: -1), // To make it more compact like mockup
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[100],
      indent: 16,
      endIndent: 16,
    );
  }
}
