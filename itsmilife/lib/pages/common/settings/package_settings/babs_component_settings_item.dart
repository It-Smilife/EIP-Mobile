import 'package:flutter/material.dart';
import './icon_style.dart';
import './settings_screen_utils.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

class SettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  SettingsItem({required this.icons, this.iconStyle, required this.title, this.titleStyle, this.subtitle, this.subtitleStyle, this.backgroundColor, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CustomPaint(
        // change color here -------------------------------------------------------------------------------------------
        painter: _RectColorPainter(color: darkMode.darkMode == true? Color.fromARGB(255, 79, 79, 79) : Colors.white),
        child: ListTile(
          onTap: onTap,
          leading: (iconStyle != null && iconStyle!.withBackground!)
              ? Container(
                  decoration: BoxDecoration(
                    color: iconStyle!.backgroundColor,
                    borderRadius: BorderRadius.circular(iconStyle!.borderRadius!),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    icons,
                    size: SettingsScreenUtils.settingsGroupIconSize,
                    color: iconStyle!.iconsColor,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    icons,
                    size: SettingsScreenUtils.settingsGroupIconSize,
                    color: darkMode.darkMode ? Colors.white : Colors.grey
                  ),
                ),
          title: Text(
            title,
            style: titleStyle ?? TextStyle(fontWeight: FontWeight.bold, color: darkMode.darkMode == true ? Colors.white : Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: (subtitle != null)
              ? Text(
                  subtitle!,
                  style: subtitleStyle ?? TextStyle(fontWeight: FontWeight.normal, color: darkMode.darkMode == true ? Colors.white : Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: (trailing != null) ? trailing : Icon(Icons.navigate_next, color: darkMode.darkMode ? Colors.white : Colors.grey,),
        ),
      ),
    );
  }
}

class _RectColorPainter extends CustomPainter {
  final Color color;

  _RectColorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
