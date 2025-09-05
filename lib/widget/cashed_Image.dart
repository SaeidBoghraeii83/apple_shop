import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CashedImage extends StatelessWidget {
  String imageUrl;
  BoxFit fit;
  CashedImage({super.key, required this.imageUrl, required this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(15.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => Container(color: Colors.blueGrey),
        errorWidget: (context, url, error) => Container(color: Colors.red[700]),
      ),
    );
  }
}
