import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/color.dart';
import 'package:login_withpet/component/letter/create_letter_screen.dart';

AppBar buildAppBar(BuildContext context, {String currentScreen = 'main'} ) {
  if(currentScreen == 'write') {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.close, color: colorSub3),
        onPressed: () { Navigator.pop(context); }
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.save_outlined, color: colorSub3),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateLetterScreen())
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.check, color: colorSub3),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateLetterScreen())
            );
          },
        ),
      ],
    );
  }

  if(currentScreen == 'edit') {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.close, color: colorSub3),
        onPressed: () { Navigator.pop(context); }
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline, color: colorSub3),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateLetterScreen())
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.check, color: colorSub3),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateLetterScreen())
            );
          },
        ),
      ],
    );
  }

  return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '편지',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w700, color: colorText),
      ),
      centerTitle: true,
      elevation: 0.0,
      actions: [
        IconButton(
          icon: const Icon(Icons.create_outlined, color: colorSub3),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateLetterScreen())
            );
          },
        )
      ],
    );
}
