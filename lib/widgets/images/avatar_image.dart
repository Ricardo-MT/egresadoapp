import 'package:flutter/material.dart';

enum MuiAvatarImageSize { s, m, l }

class AvatarImage extends StatelessWidget {
  double? customSize;
  bool withHero;
  MuiAvatarImageSize size;
  String? url;
  AvatarImage(
      {Key? key,
      this.size = MuiAvatarImageSize.s,
      this.withHero = false,
      this.customSize,
      this.url})
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
    Widget component = SizedBox(
      width: s,
      height: s,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(s / 2),
        clipBehavior: Clip.hardEdge,
        child: url == null
            ? Image.asset(
                "assets/images/user.png",
                fit: BoxFit.cover,
                width: s,
                height: s,
              )
            : Image.network(
                url!,
                headers: const {
                  "Access-Control-Allow-Origin": "*",
                  "Access-Control-Allow-Methods":
                      "GET, POST, PUT, DELETE, OPTIONS, HEAD",
                  "Access-Control-Allow-Headers":
                      "Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Origin"
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
    return withHero ? Hero(tag: "avatar$url", child: component) : component;
  }
}
