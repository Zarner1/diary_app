import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA),
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 150,
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.network(
                        'https://res.cloudinary.com/dckbc5poi/image/upload/v1743972343/ChatGPT_Image_Apr_6_2025_09_40_41_PM_b5pubk.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Diary+',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.book,
              title: 'My Diaries',
              route: '/diaries',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.add,
              title: 'New Diary',
              route: '/view-diary',
              isNew: true,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              title: 'Settings',
              route: '/settings',
            ),
            const Divider(
              color: Colors.teal,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              leading: Icon(
                Icons.exit_to_app,
                size: 28,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String route,
        bool isNew = false,
      }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      leading: Icon(
        icon,
        size: 28,
        color: isNew ? Colors.amber.shade700 : Colors.teal.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.teal.shade900,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
