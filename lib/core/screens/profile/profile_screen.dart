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
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: CustomScrollView(
            shrinkWrap: true,
            scrollBehavior: const ScrollBehavior().copyWith(
              overscroll: false,
            ),
            slivers: [
              SliverAppBar(
                centerTitle: false,
                backgroundColor: AppColors.primaryColor,
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: AppFontSize.fontSizeXXL,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacingM,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: AppSpacing.spacingS),
                      _buildProfileHeader(),
                      SizedBox(height: AppSpacing.spacingL),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppBorderRadius.radiusL),
                        topRight: Radius.circular(AppBorderRadius.radiusL),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.spacingM,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: AppSpacing.spacingXL),
                          _buildSectionTitle("Account Settings"),
                          _buildListTile(
                            icon: Icons.person_outline,
                            title: "Personal Information",
                            route: () {
                              context.go('/profile/personal-information');
                            },
                          ),
                          _buildListTile(
                            icon: Icons.security,
                            title: "Password & Security",
                            route: () {
                              context.go('/password-security');
                            },
                          ),
                          SizedBox(height: AppSpacing.spacingXL),
                          _buildSectionTitle("Other"),
                          _buildListTile(
                            icon: Icons.settings_outlined,
                            title: "Settings",
                            route: () {
                              context.go('/profile/settings');
                            },
                          ),
                          _buildListTile(
                            icon: Icons.help_outline,
                            title: "FAQ",
                            route: () {
                              context.go('/profile/faq');
                            },
                          ),
                          _buildListTile(
                            icon: Icons.headset_mic_outlined,
                            title: "Help Center",
                            route: () {
                              context.go('/profile/help-center');
                            },
                          ),
                          _buildListTile(
                            icon: Icons.info_outline,
                            title: "About",
                            route: () {
                              context.go('profile/about');
                            },
                          ),
                          SizedBox(height: AppSpacing.spacingXL),
                          _buildLogoutButton(
                            onPressed: () {
                              context.go('/landing');
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(profileImageUrl),
        ),
        SizedBox(width: AppSpacing.spacingL),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: AppFontSize.fontSizeXL,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            SizedBox(height: AppSpacing.spacingS),
            Text(
              email,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: AppFontSize.fontSizeS,
                fontWeight: AppFontWeight.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: AppFontWeight.semiBold,
          fontSize: AppFontSize.fontSizeMS,
        ),
      ),
    );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required Function() route}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: Colors.grey[700],
        size: AppIconSize.iconS,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppFontSize.fontSizeM,
          color: AppColors.textColor,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.textMutedColor),
      onTap: () {
        route();
      },
    );
  }

  Widget _buildLogoutButton({required Function() onPressed}) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.backgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.errorColor),
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
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
                                context.read<AuthBloc>().add(LogoutRequested());
                              },
                              child: const Text(
                                'Keluar',
                                style: TextStyle(color: AppColors.errorColor),
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
                          AlwaysStoppedAnimation<Color>(AppColors.errorColor),
                    ),
                  )
                : const Text(
                    "Keluar",
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeM,
                      color: AppColors.errorColor,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
