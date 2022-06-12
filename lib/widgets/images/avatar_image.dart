import 'package:flutter/material.dart';

enum MuiAvatarImageSize { s, m, l }

class AvatarImage extends StatelessWidget {
  double? customSize;
  MuiAvatarImageSize size;
  String? url;
  AvatarImage(
      {Key? key, this.size = MuiAvatarImageSize.s, this.customSize, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double s = 24.0;
    switch (size) {
      case MuiAvatarImageSize.s:
        s = 14;
        break;
      case MuiAvatarImageSize.m:
        s = 24;
        break;
      case MuiAvatarImageSize.l:
        s = 50;
        break;
      default:
    }
    s = customSize ?? s;
    return SizedBox(
      width: s,
      height: s,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(s / 2),
        clipBehavior: Clip.hardEdge,
        child: url == null
            // https://egresadoapp.web.app
            // https://egresadoapp.firebaseapp.com
            // http://localhost:8000
            ? Image.asset(
                "assets/images/user.png",
                fit: BoxFit.cover,
                width: s,
                height: s,
              )
            : Image.network(
                url!,
                headers: const {
                  "Origin": "https://egresadoapp.web.app",
                  "Access-Control-Allow-Origin": "*",
                  "Accept": "*/*",
                  "Access-Control-Allow-Methods":
                      "GET, POST, PUT, DELETE, OPTIONS, HEAD"
                },
                errorBuilder: (context, object, tr) {
                  return Image.asset(
                    "assets/images/user.png",
                    fit: BoxFit.cover,
                    width: s,
                    height: s,
                  );
                },
                fit: BoxFit.cover,
                height: s,
                width: s,
              ),
      ),
    );
  }
}
