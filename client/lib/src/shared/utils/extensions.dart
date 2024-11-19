import 'package:flutter/material.dart';

extension ShadowedContainer on Container {
  Container withDefaultBoxShadow() {
    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: (decoration as BoxDecoration?)?.copyWith(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF10212A),
                offset: Offset(0, 8),
                blurRadius: 0,
              )
            ],
          ) ??
          BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF10212A),
                offset: Offset(0, 8),
                blurRadius: 0,
              )
            ],
          ),
      margin: margin,
      transform: transform,
      constraints: constraints,
      child: child,
    );
  }
}
