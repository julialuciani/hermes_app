import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class AppTypography {
  AppTypography._();

  static Typography? _typography;

  static Typography get typography {
    if (_typography != null) return _typography!;
    _typography = Typography(
        bold: Bold(
          extraLarge: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          large: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          medium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          small: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          extraSmall: GoogleFonts.inter(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        regular: Regular(
          extraLarge: GoogleFonts.inter(
            fontSize: 24,
            color: AppColors.black,
          ),
          large: GoogleFonts.inter(
            fontSize: 20,
            color: AppColors.black,
          ),
          medium: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.black,
          ),
          small: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.black,
          ),
          extraSmall: GoogleFonts.inter(
            fontSize: 8,
            color: AppColors.black,
          ),
        ),
        paragraph: Paragraph(
          extraLarge: GoogleFonts.inter(
            fontSize: 24,
            color: AppColors.grey,
          ),
          large: GoogleFonts.inter(
            fontSize: 20,
            color: AppColors.grey,
          ),
          medium: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.grey,
          ),
          small: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.grey,
          ),
          extraSmall: GoogleFonts.inter(
            fontSize: 8,
            color: AppColors.grey,
          ),
        ));
    return _typography!;
  }
}

class Typography {
  final Bold bold;
  final Regular regular;
  final Paragraph paragraph;
  const Typography({
    required this.bold,
    required this.regular,
    required this.paragraph,
  });
}

class Bold {
  final TextStyle extraLarge;
  final TextStyle large;
  final TextStyle medium;
  final TextStyle small;
  final TextStyle extraSmall;

  const Bold({
    required this.extraLarge,
    required this.large,
    required this.medium,
    required this.small,
    required this.extraSmall,
  });
}

class Regular {
  final TextStyle extraLarge;
  final TextStyle large;
  final TextStyle medium;
  final TextStyle small;
  final TextStyle extraSmall;

  const Regular({
    required this.extraLarge,
    required this.large,
    required this.medium,
    required this.small,
    required this.extraSmall,
  });
}

class Paragraph {
  final TextStyle extraLarge;
  final TextStyle large;
  final TextStyle medium;
  final TextStyle small;
  final TextStyle extraSmall;

  const Paragraph({
    required this.extraLarge,
    required this.large,
    required this.medium,
    required this.small,
    required this.extraSmall,
  });
}
