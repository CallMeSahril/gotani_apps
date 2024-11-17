import 'package:flutter/material.dart';

class ValidationPopUp extends StatelessWidget {
  final String? title;
  final String pesan;
  final VoidCallback? onPressed;
  final String? buttonLabel;

  const ValidationPopUp({
    Key? key,
    this.title,
    required this.pesan,
    this.onPressed,
    this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            if (title != null)
              const SizedBox(height: 16), // Space if title exists
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16), // Space before buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Replace with `pDarkBlueColor`
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.05),
                    ),
                  ),
                  child: Text(
                    "Batal",
                    style: const TextStyle(
                        color: Colors.white), // Replace with `pWhiteColor`
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Replace with `pDarkBlueColor`
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.05),
                    ),
                  ),
                  child: Text(
                    buttonLabel ?? "Ya",
                    style: const TextStyle(
                        color: Colors.white), // Replace with `pWhiteColor`
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
