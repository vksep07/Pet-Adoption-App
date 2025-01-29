import 'package:flutter/material.dart';
import 'package:pet_adoption/common/widgets/common_text.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageZoomPage extends StatelessWidget {
  final ImageProvider imageProvider;
  final Color bgColor;

  const ImageZoomPage({
    super.key,
    required this.imageProvider,
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: appLocalizations.zoomedImage),
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(color: bgColor),
        imageProvider: imageProvider,
      ),
    );
  }
}
