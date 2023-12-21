import 'package:flutter/material.dart';
import 'package:metatube/utils/app_theme.dart';

class SnakeBarUtils {
  static void showSnakBar(BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.disableBackgroundColor,

        content: Center(
          child: Row(
            children: [
              Icon(
                icon,
                color: AppTheme.accent,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                message,
                style: AppTheme.inputStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
