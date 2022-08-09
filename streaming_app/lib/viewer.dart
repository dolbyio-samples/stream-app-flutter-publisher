import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:millicast_flutter_sdk/millicast_flutter_sdk.dart';

Future viewConnect(RTCVideoRenderer localRenderer) async {
  // Setting subscriber options
  DirectorSubscriberOptions directorSubscriberOptions =
      DirectorSubscriberOptions(
          streamAccountId: 'tsrKzd', streamName: 'l6fgs84g');

  /// Define callback for generate new token
  tokenGenerator() => Director.getSubscriber(directorSubscriberOptions);

  /// Create a new instance
  View view = View(
      streamName: 'my-stream-name',
      tokenGenerator: tokenGenerator,
      mediaElement: localRenderer);

  /// Start connection to publisher
  try {
    await view.connect();
    return view.webRTCPeer;
  } catch (e) {
    rethrow;
  }
}
