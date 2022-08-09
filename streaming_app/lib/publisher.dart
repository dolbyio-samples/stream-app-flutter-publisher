//Publisher.Dart handles Dolby.io Streaming functionality.

import 'dart:io';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:millicast_flutter_sdk/millicast_flutter_sdk.dart';

Future publishConnect(RTCVideoRenderer localRenderer, String accID,
    String streamName, String pubTok) async {
  // Setting subscriber options
  DirectorPublisherOptions directorPublisherOptions =
      DirectorPublisherOptions(token: pubTok, streamName: streamName);

  /// Define callback for generate new token
  tokenGenerator() => Director.getPublisher(directorPublisherOptions);

  /// Create a new instance
  Publish publish =
      Publish(streamName: 'my-streamname', tokenGenerator: tokenGenerator);

  final Map<String, dynamic> constraints = <String, bool>{
    'audio': true,
    'video': true
  };

  MediaStream stream = await navigator.mediaDevices.getUserMedia(constraints);
  localRenderer.srcObject = stream;

  //Publishing Options
  Map<String, dynamic> broadcastOptions = {'mediaStream': stream};
  //Some Android devices do not support h264 codec for publishing
  if (Platform.isAndroid) {
    broadcastOptions['codec'] = 'vp8';
  }

  /// Start connection to publisher
  await publish.connect(options: broadcastOptions);
  return publish;
}
