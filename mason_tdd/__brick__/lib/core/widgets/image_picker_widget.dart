import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File) onImageSelected;
  final Function()? onImageRemoved;
  final String? initialImagePath;
  final double width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final IconData? placeholderIcon;
  final String? placeholderText;
  final bool showRemoveButton;
  final bool isCircular;

  const ImagePickerWidget({
    Key? key,
    required this.onImageSelected,
    this.onImageRemoved,
    this.initialImagePath,
    this.width = 120,
    this.height = 120,
    this.borderRadius = 12,
    this.backgroundColor,
    this.placeholderIcon = Icons.add_a_photo,
    this.placeholderText = 'Add Photo',
    this.showRemoveButton = true,
    this.isCircular = false,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.initialImagePath != null) {
      _selectedImage = File(widget.initialImagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _showImagePickerOptions,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color:
                  widget.backgroundColor ??
                  Theme.of(context).colorScheme.surface,
              borderRadius: widget.isCircular
                  ? BorderRadius.circular(widget.width / 2)
                  : BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: _selectedImage != null
                ? _buildImagePreview()
                : _buildPlaceholder(),
          ),
        ),
        if (widget.showRemoveButton && _selectedImage != null)
          Positioned(
            top: -8,
            right: -8,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: widget.isCircular
          ? BorderRadius.circular(widget.width / 2)
          : BorderRadius.circular(widget.borderRadius),
      child: Image.file(
        _selectedImage!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.placeholderIcon,
          size: 32,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(height: 8),
        Text(
          widget.placeholderText!,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildImagePickerBottomSheet(),
    );
  }

  Widget _buildImagePickerBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Image Source',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOptionCard(
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () => _pickImageFromCamera(),
              ),
              _buildOptionCard(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () => _pickImageFromGallery(),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromCamera() async {
    try {
      // This would be implemented with the ImagePickerService
      // For now, we'll show a placeholder implementation
      _showNotImplementedSnackBar();
    } catch (e) {
      _showErrorSnackBar('Failed to pick image from camera: $e');
    }
  }

  void _pickImageFromGallery() async {
    try {
      // This would be implemented with the ImagePickerService
      // For now, we'll show a placeholder implementation
      _showNotImplementedSnackBar();
    } catch (e) {
      _showErrorSnackBar('Failed to pick image from gallery: $e');
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageRemoved?.call();
  }

  void _showNotImplementedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Image picker functionality will be implemented with ImagePickerService',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Multiple Image Picker Widget
class MultipleImagePickerWidget extends StatefulWidget {
  final Function(List<File>) onImagesSelected;
  final List<String>? initialImagePaths;
  final int maxImages;
  final double itemWidth;
  final double itemHeight;
  final double borderRadius;
  final Color? backgroundColor;

  const MultipleImagePickerWidget({
    Key? key,
    required this.onImagesSelected,
    this.initialImagePaths,
    this.maxImages = 5,
    this.itemWidth = 100,
    this.itemHeight = 100,
    this.borderRadius = 8,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<MultipleImagePickerWidget> createState() =>
      _MultipleImagePickerWidgetState();
}

class _MultipleImagePickerWidgetState extends State<MultipleImagePickerWidget> {
  List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialImagePaths != null) {
      _selectedImages = widget.initialImagePaths!
          .map((path) => File(path))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Images',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ..._selectedImages.map((image) => _buildImageItem(image)),
            if (_selectedImages.length < widget.maxImages) _buildAddButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildImageItem(File image) {
    return Stack(
      children: [
        Container(
          width: widget.itemWidth,
          height: widget.itemHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Image.file(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.broken_image,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: GestureDetector(
            onTap: () => _removeImage(image),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        width: widget.itemWidth,
        height: widget.itemHeight,
        decoration: BoxDecoration(
          color:
              widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(height: 4),
            Text(
              'Add',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildImagePickerBottomSheet(),
    );
  }

  Widget _buildImagePickerBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Images',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOptionCard(
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () => _pickImageFromCamera(),
              ),
              _buildOptionCard(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () => _pickMultipleImagesFromGallery(),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromCamera() async {
    try {
      // This would be implemented with the ImagePickerService
      _showNotImplementedSnackBar();
    } catch (e) {
      _showErrorSnackBar('Failed to pick image from camera: $e');
    }
  }

  void _pickMultipleImagesFromGallery() async {
    try {
      // This would be implemented with the ImagePickerService
      _showNotImplementedSnackBar();
    } catch (e) {
      _showErrorSnackBar('Failed to pick images from gallery: $e');
    }
  }

  void _removeImage(File image) {
    setState(() {
      _selectedImages.remove(image);
    });
    widget.onImagesSelected(_selectedImages);
  }

  void _showNotImplementedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Image picker functionality will be implemented with ImagePickerService',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
