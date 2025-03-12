import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrpcService {
  GrpcService() {
    _initChannel();
  }

  void _initChannel() {
    // TODO: Implement actual gRPC channel when proto files are generated
  }

  Future<void> shutdown() async {
    // TODO: Implement shutdown when channel is implemented
  }
}

final grpcServiceProvider = Provider<GrpcService>((ref) {
  final service = GrpcService();
  ref.onDispose(() async {
    await service.shutdown();
  });
  return service;
});