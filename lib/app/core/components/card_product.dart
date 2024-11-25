import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.link,
    required this.image,
    required this.text,
  }) : super(key: key);

  final void Function() link;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.005,
          vertical: size.width * 0.01,
        ),
        padding: EdgeInsets.all(size.width * 0.005),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
          ),
          onPressed: link,
          child: Column(
            children: [
              SizedBox(
                  width: size.width * 0.21,
                  height: size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    child: Image.network(image, fit: BoxFit.cover),
                  )),
              Container(
                width: size.height * 0.08,
                margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.height * 0.012,
                      color: Color(0xff0E803C),
                    )),
              )
            ],
          ),
        ));
  }
}
