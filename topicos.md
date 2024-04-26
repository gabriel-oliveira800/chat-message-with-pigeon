## Observação

- Não possui suporte para linux - (https://github.com/flutter/flutter/issues/73740)
- [Type Mappings](https://docs.flutter.dev/platform-integration/platform-channels?tab=type-mappings-kotlin#codec)

<image src="assets/01.png">

- Não possui suporte a [EventChannel](https://github.com/flutter/flutter/issues/66711)

```dart

@HostApi()
abstract class VideoPlayerApi {
  Stream<VideoEvent> get videoEvents;
  void dispose();

  void setLooping(LoopingMessage msg);
  void setVolume(VolumeMessage msg);

  void play();
  PositionMessage position();
  void seekTo(PositionMessage msg);

  void pause();
  void setMixWithOthers(MixWithOthersMessage msg);
}

```
