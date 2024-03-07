import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Styles/light_theme.dart';
import '../provider/theme_provider.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color.fromARGB(255, 66, 133, 244),
          Color.fromARGB(255, 155, 114, 203),
          Color.fromARGB(255, 217, 101, 112),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28.0, // adjust font size as desired
          fontWeight: FontWeight.bold, // adjust font weight as desired
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        100,
      );
}

class _CustomAppBarState extends State<CustomAppBar> {
  Icon iconChange(ThemeData themeData) {
    IconData icon;
    Color iconColor;
    if (themeData == lighttheme) {
      icon = Icons.nightlight_outlined;
      iconColor = Colors.red;
    } else {
      icon = Icons.sunny;
      iconColor = Colors.yellow;
    }

    return Icon(
      icon,
      size: 30.0,
      color: iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientText(text: "Hello,"), // Use GradientText here
                  Text(
                    "Here's Your To-Dos",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                child:
                    iconChange(Provider.of<ThemeProvider>(context).themeData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
