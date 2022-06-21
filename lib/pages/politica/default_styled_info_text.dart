import 'dart:math';

import 'package:egresadoapp/utils/deeplinking.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/scale_in_wrapper.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/footer/privacyfooter.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:egresadoapp/widgets/logo/logo.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MuiMarkedInfoPage extends StatelessWidget {
  final String backgroundImage;
  final String markdownTextFile;
  const MuiMarkedInfoPage(
      {Key? key, required this.backgroundImage, required this.markdownTextFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Logo(
          height: 40,
        ),
      ),
      persistentFooterButtons: const [Center(child: PrivacyFooter())],
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        child: SafeArea(
          top: true,
          child: Center(
            child: SizedBox(
              width: min(800, MediaQuery.of(context).size.width - 40),
              child: Column(
                children: [
                  spacerS,
                  Expanded(
                    child: FutureBuilder(
                      future: rootBundle.loadString(markdownTextFile),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return _Header(child: const MuiErrorWidget());
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _Header(child: const Loading());
                        }
                        return _Header(
                            child: ScaleInWrapper(
                          index: 2,
                          child: Markdown(
                            data: snapshot.data as String,
                            onTapLink: (v1, v2, v3) {
                              openExternally(v2 ?? v1);
                            },
                            styleSheetTheme:
                                MarkdownStyleSheetBaseTheme.platform,
                            styleSheet: MarkdownStyleSheet(
                                strong: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                                h1: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                h1Align: WrapAlignment.center,
                                h1Padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                blockSpacing: 10,
                                h2: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                                h2Padding: _hPadding,
                                h3Padding:
                                    _hPadding.copyWith(bottom: _hPadding.top),
                                h3: const TextStyle(
                                  color: Colors.white,
                                ),
                                h4: const TextStyle(
                                  color: Colors.white,
                                ),
                                h4Padding:
                                    _hPadding.copyWith(bottom: _hPadding.top),
                                h4Align: WrapAlignment.center,
                                p: const TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ));
                      },
                    ),
                  ),
                  // const PrivacyFooter()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  Widget child;
  _Header({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

const _hPadding = EdgeInsets.only(top: 20);
