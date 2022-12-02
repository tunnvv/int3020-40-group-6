class Server {
  final String id;
  final String hostId;
  final String name;
  final String createdAt;

  const Server({
    required this.id,
    required this.hostId,
    required this.name,
    required this.createdAt,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json['_id'],
      hostId: json['hostId'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }
}