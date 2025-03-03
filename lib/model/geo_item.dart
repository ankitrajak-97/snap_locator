class GeoTaggedItem {
  final String name;
  final String description;
  final String? imagePath;
  final double latitude; // Store latitude
  final double longitude; // Store longitude

  GeoTaggedItem({
    required this.name,
    required this.description,
    this.imagePath,
    required this.latitude,
    required this.longitude,
  });
}
