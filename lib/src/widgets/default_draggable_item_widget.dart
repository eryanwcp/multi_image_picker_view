import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:multi_image_picker_view/src/multi_image_picker_controller_wrapper.dart';
import 'package:photo_view/photo_view.dart';

class DefaultDraggableItemWidget extends StatelessWidget {
  const DefaultDraggableItemWidget({
    super.key,
    required this.imageFile,
    this.fit = BoxFit.cover,
    this.boxDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    this.showCloseButton = true,
    this.closeButtonAlignment = Alignment.topRight,
    this.closeButtonIcon,
    this.closeButtonBoxDecoration,
    this.closeButtonMargin = const EdgeInsets.all(4),
    this.closeButtonPadding = const EdgeInsets.all(3),
  });

  final ImageFile imageFile;
  final BoxFit fit;
  final BoxDecoration? boxDecoration;
  final bool showCloseButton;
  final Alignment closeButtonAlignment;
  final Widget? closeButtonIcon;
  final BoxDecoration? closeButtonBoxDecoration;
  final EdgeInsetsGeometry closeButtonMargin;
  final EdgeInsetsGeometry closeButtonPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: boxDecoration,
            child:
            // ImageFileView(
            //   fit: fit,
            //   imageFile: imageFile,
            // ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    OneTapWrapper(imageProvider: FileImage(File(imageFile!.path!)),
                    ),
                  ),
                );
              },
              child: Container(
                child: Hero(
                  tag: "someTag_${imageFile!.path}",
                  child: ImageFileView(
                    fit: fit,
                    imageFile: imageFile,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showCloseButton)
          Positioned.fill(
            child: Align(
              alignment: closeButtonAlignment,
              child: Padding(
                padding: closeButtonMargin,
                child: DraggableItemInkWell(
                  onPressed: () => MultiImagePickerControllerWrapper.of(context)
                      .controller
                      .removeImage(imageFile),
                  child: Container(
                      padding: closeButtonPadding,
                      decoration: closeButtonBoxDecoration ??
                          BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                      child: closeButtonIcon ??
                          Icon(Icons.close,
                              size: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class OneTapWrapper extends StatelessWidget {
  const OneTapWrapper({super.key,
    this.imageProvider,
  });

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: GestureDetector(
          onTapDown: (_) {
            Navigator.pop(context);
          },
          child: PhotoView(
            imageProvider: imageProvider,
          ),
        ),
      )),
    );
  }
}
