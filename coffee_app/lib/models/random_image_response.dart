class RandomImageResponse {
  final String file;

  RandomImageResponse(this.file);

  RandomImageResponse.fromJson(Map<String, dynamic> json) : file = json['file'];

  Map<String, dynamic> toJson() => {'file': file};
}