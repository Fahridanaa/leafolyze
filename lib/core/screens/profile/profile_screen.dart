import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/blocs/auth/auth_bloc.dart';
import 'package:leafolyze/blocs/auth/auth_event.dart';
import 'package:leafolyze/blocs/auth/auth_state.dart';
import 'package:leafolyze/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String profileImageUrl;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go('/landing');
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.GreenLogodanButton,
          body: Column(
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 15),
              _buildProfileHeader(),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      _buildSectionTitle("Account Settings"),
                      _buildListTile(
                        icon: Icons.person_outline,
                        title: "Personal Information",
                      ),
                      _buildListTile(
                        icon: Icons.security,
                        title: "Password & Security",
                      ),
                      SizedBox(height: 30),
                      _buildSectionTitle("Other"),
                      _buildListTile(
                        icon: Icons.settings_outlined,
                        title: "Settings",
                      ),
                      _buildListTile(
                        icon: Icons.help_outline,
                        title: "FAQ",
                      ),
                      _buildListTile(
                        icon: Icons.headset_mic_outlined,
                        title: "Help Center",
                      ),
                      _buildListTile(
                        icon: Icons.info_outline,
                        title: "About",
                      ),
                      SizedBox(height: 20),
                      _buildLogoutButton(
                        onPressed: () {
                          context.go('/landing');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: () {
        // navigation
      },
    );
  }

  Widget _buildLogoutButton({required Function() onPressed}) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.logoRed),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: state is AuthLoading
                  ? null // Disable button while loading
                  : () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content:
                                const Text('Apakah Anda yakin ingin keluar?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  context
                                      .read<AuthBloc>()
                                      .add(LogoutRequested());
                                },
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(color: AppColors.logoRed),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
              child: state is AuthLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.logoRed),
                      ),
                    )
                  : const Text(
                      "Keluar",
                      style: TextStyle(color: AppColors.logoRed, fontSize: 16),
                    ),
            ),
          ),
        );
      },
    );
  }
}
