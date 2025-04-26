import 'dart:typed_data';

/// Store the image data and other information.
class ImageFile {
  final String key;
  String? fileId;
  final String name;
  final String extension;
  final Uint8List? bytes;
  final String? path;
  DateTime? lastModified;

  /// returns true if image has path. (For web path is not available)
  bool get hasPath => path != null;

  /// returns size of bytes if image has bytes, else 0.
  int get size => bytes?.length ?? 0;

  ImageFile(this.key,
      {required this.name,this.fileId, required this.extension, this.bytes, this.path,this.lastModified});

  List<Object?> get props => [path, bytes];

  @override
  String toString() {
    return '''{
      'key': $key,
      'fileId': $fileId,
      'name': $name,
      'extension': $extension,
      'bytes': ${bytes?.length},
      'path': $path,
      'lastModified': $lastModified
    }''';
  }
}
