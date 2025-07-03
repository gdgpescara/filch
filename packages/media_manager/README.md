# Media Manager Package

Media management package providing functionality for handling images, videos, and other media content including camera integration, image processing, and cloud storage.

## Features

### Implemented Functionality

- Camera integration for photo/video capture
- Image picker from gallery
- Image compression and optimization
- Cloud storage upload/download
- Image caching and offline support
- Video thumbnail generation
- Image cropping and editing
- Media metadata extraction

### Camera Integration

#### Photo Capture

```dart
class CameraService {
  Future<File?> capturePhoto({
    CameraLensDirection preferredLens = CameraLensDirection.back,
    ImageQuality quality = ImageQuality.high,
  });
  
  Future<File?> captureVideo({
    Duration? maxDuration,
    VideoQuality quality = VideoQuality.high,
  });
}
```

#### Gallery Selection

```dart
class GalleryService {
  Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    ImageQuality quality = ImageQuality.medium,
  });
  
  Future<List<File>> pickMultipleImages({
    int maxImages = 10,
  });
}
```

### Image Processing

#### Compression

```dart
class ImageProcessor {
  Future<File> compressImage(
    File image, {
    int quality = 85,
    int? maxWidth,
    int? maxHeight,
  });
  
  Future<File> resizeImage(
    File image, {
    required int width,
    required int height,
    bool maintainAspectRatio = true,
  });
}
```

#### Cropping

```dart
class ImageCropper {
  Future<File?> cropImage(
    File image, {
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPreset> aspectRatioPresets = const [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio16x9,
    ],
  });
}
```

### Cloud Storage

#### Upload Service

```dart
class CloudStorageService {
  Future<String> uploadImage(
    File image, {
    required String path,
    UploadProgress? onProgress,
  });
  
  Future<String> uploadVideo(
    File video, {
    required String path,
    UploadProgress? onProgress,
  });
  
  Future<void> deleteMedia(String url);
}
```

#### Download Service

```dart
class MediaDownloader {
  Future<File> downloadImage(String url);
  Future<File> downloadVideo(String url);
  Future<void> preloadImages(List<String> urls);
}
```

### Caching

#### Image Cache

```dart
class ImageCacheManager {
  Future<File?> getCachedImage(String url);
  Future<void> cacheImage(String url);
  Future<void> clearCache();
  Future<int> getCacheSize();
}
```

## Data Models

### MediaFile

Base media file model:

```dart
class MediaFile extends Equatable {
  final String id;                        // Unique identifier
  final String name;                      // File name
  final String url;                       // Remote URL
  final String? localPath;                // Local file path
  final MediaType type;                   // File type
  final int size;                         // File size in bytes
  final DateTime createdAt;               // Creation timestamp
  final MediaMetadata? metadata;          // File metadata
}
```

### MediaType

Media type enumeration:

- `image` - Image file
- `video` - Video file
- `audio` - Audio file
- `document` - Document file

### MediaMetadata

Media file metadata:

```dart
class MediaMetadata extends Equatable {
  final int? width;                       // Image/video width
  final int? height;                      // Image/video height
  final Duration? duration;               // Video/audio duration
  final String? mimeType;                 // MIME type
  final Map<String, dynamic>? exif;      // EXIF data
  final Location? location;               // GPS location
}
```

### UploadProgress

Upload progress tracking:

```dart
class UploadProgress {
  final int bytesTransferred;             // Bytes uploaded
  final int totalBytes;                   // Total bytes
  final double percentage;                // Upload percentage
  final UploadState state;                // Upload state
}
```

### UploadState

Upload state enumeration:

- `pending` - Upload queued
- `uploading` - Upload in progress
- `completed` - Upload completed
- `failed` - Upload failed
- `cancelled` - Upload cancelled

## Use Cases

### Media Capture

- **CapturePhotoUseCase** - Capture photo with camera
- **CaptureVideoUseCase** - Capture video with camera
- **PickImageFromGalleryUseCase** - Select image from gallery
- **PickMultipleImagesUseCase** - Select multiple images

### Media Processing

- **CompressImageUseCase** - Compress image file
- **ResizeImageUseCase** - Resize image
- **CropImageUseCase** - Crop image
- **GenerateVideoThumbnailUseCase** - Generate video thumbnail
- **ExtractMediaMetadataUseCase** - Extract file metadata

### Cloud Storage

- **UploadMediaUseCase** - Upload media to cloud storage
- **DownloadMediaUseCase** - Download media from cloud
- **DeleteMediaUseCase** - Delete media from cloud
- **GetMediaUrlUseCase** - Get media download URL

### Cache Management

- **CacheMediaUseCase** - Cache media locally
- **GetCachedMediaUseCase** - Get cached media
- **ClearMediaCacheUseCase** - Clear media cache
- **GetCacheSizeUseCase** - Get cache size

## State Management

### MediaBloc

Manages media operations state.

#### Media States

- **MediaInitial** - Initial state
- **MediaLoading** - Loading media
- **MediaLoaded** - Media loaded
- **MediaUploading** - Upload in progress
- **MediaUploaded** - Upload completed
- **MediaError** - Media operation error

#### Media Events

- **MediaCaptureRequested** - Capture media
- **MediaUploadRequested** - Upload media
- **MediaDeleteRequested** - Delete media
- **MediaCacheRequested** - Cache media

### UploadBloc

Manages upload operations state.

#### Upload States

- **UploadInitial** - No uploads
- **UploadInProgress** - Upload in progress
- **UploadCompleted** - Upload completed
- **UploadFailed** - Upload failed

#### Upload Events

- **UploadStarted** - Start upload
- **UploadProgressUpdated** - Progress update
- **UploadCompleted** - Upload finished
- **UploadCancelled** - Cancel upload

## Widgets

### MediaPicker

Media picker widget with camera and gallery options.

```dart
MediaPicker(
  allowMultiple: true,
  mediaType: MediaType.image,
  maxImages: 5,
  onMediaSelected: (files) => handleSelection(files),
  onError: (error) => showError(error),
)
```

### ImageViewer

Image viewer with zoom and pan capabilities.

```dart
ImageViewer(
  imageUrl: imageUrl,
  heroTag: 'image_hero',
  onDownload: () => downloadImage(),
  onShare: () => shareImage(),
  onDelete: () => deleteImage(),
)
```

### VideoPlayer

Video player widget.

```dart
VideoPlayer(
  videoUrl: videoUrl,
  autoPlay: false,
  showControls: true,
  onVideoEnd: () => handleVideoEnd(),
)
```

### UploadProgress

Upload progress indicator.

```dart
UploadProgressWidget(
  progress: uploadProgress,
  fileName: 'image.jpg',
  onCancel: () => cancelUpload(),
)
```

### MediaGrid

Grid view for displaying media files.

```dart
MediaGrid(
  mediaFiles: files,
  crossAxisCount: 3,
  onMediaTap: (file) => openViewer(file),
  onMediaLongPress: (file) => showOptions(file),
)
```

### CameraPreview

Camera preview widget.

```dart
CameraPreview(
  onCapture: (file) => handleCapture(file),
  onSwitchCamera: () => switchCamera(),
  enableFlash: true,
  showGrid: true,
)
```

## Configuration

### Media Configuration

```dart
class MediaConfig {
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
  static const int defaultImageQuality = 85;
  static const int cacheMaxSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheMaxAge = Duration(days: 7);
}
```

### Upload Configuration

```dart
class UploadConfig {
  static const String imagePath = 'images/';
  static const String videoPath = 'videos/';
  static const int maxConcurrentUploads = 3;
  static const Duration uploadTimeout = Duration(minutes: 5);
}
```

## Firebase Storage Integration

### Storage Structure

```
storage/
├── images/
│   ├── users/{userId}/
│   │   ├── profile/
│   │   └── quests/
│   └── quests/{questId}/
└── videos/
    ├── users/{userId}/
    └── quests/{questId}/
```

### Security Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User images
    match /images/users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Quest images (public read)
    match /images/quests/{questId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

## Error Handling

### MediaException

Custom exception for media operations:

```dart
class MediaException extends CustomError {
  MediaException({
    required String code,
    required String message,
    this.details,
  });
  
  final Map<String, dynamic>? details;
}
```

### Common Error Codes

- `camera_permission_denied` - Camera permission not granted
- `storage_permission_denied` - Storage permission not granted
- `file_too_large` - File exceeds size limit
- `unsupported_format` - Unsupported file format
- `upload_failed` - Upload operation failed
- `network_error` - Network connectivity issue

## Permissions

### Required Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is needed to capture photos for quests</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo library access is needed to select images</string>
```

## Dependencies

- `camera` - Camera integration
- `image_picker` - Gallery selection
- `image` - Image processing
- `video_player` - Video playback
- `firebase_storage` - Cloud storage
- `cached_network_image` - Image caching
- `path_provider` - File paths
- `permission_handler` - Permission management

## Usage

```dart
import 'package:media_manager/media_manager.dart';

// Capture photo
final captureUseCase = GetIt.instance<CapturePhotoUseCase>();
final result = await captureUseCase(NoParams());
result.fold(
  (error) => showError(error.message),
  (file) => handleCapturedPhoto(file),
);

// Upload media
final uploadUseCase = GetIt.instance<UploadMediaUseCase>();
final uploadResult = await uploadUseCase(
  UploadMediaParams(
    file: imageFile,
    path: 'users/${userId}/profile/',
    onProgress: (progress) => updateProgress(progress),
  ),
);

// Monitor media state
BlocBuilder<MediaBloc, MediaState>(
  builder: (context, state) {
    if (state is MediaUploading) {
      return UploadProgressWidget(progress: state.progress);
    } else if (state is MediaUploaded) {
      return SuccessWidget(message: 'Upload completed');
    }
    return MediaPicker(onMediaSelected: (files) => upload(files));
  },
)

// Display images
MediaGrid(
  mediaFiles: userImages,
  onMediaTap: (file) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImageViewer(imageUrl: file.url),
    ),
  ),
)
```
