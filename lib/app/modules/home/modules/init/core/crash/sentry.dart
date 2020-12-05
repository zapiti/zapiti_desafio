import 'dart:async';
import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sentry/sentry.dart';



final String _dsn =
    'https://4ee2429f3dc34448be492fd3f1804e2e@o487334.ingest.sentry.io/5545996';


SentryClient _sentryClient;

Future<void> runSentry(Function func) async {
  _setCustomFlutterError();

  runZoned<Future<Null>>(
        () => func.call(),
    onError: (error, stackTrace) async {
      await reportError(error, stackTrace);
    },
  );

  _sentryClient = await createClient();
  _sentryClient.userContext = await _getUserClient();
}

/**
 * Catch and report Flutter errors
 */
void _setCustomFlutterError() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}

bool get isInDebugMode {
//  bool inDebugMode = false;
//  assert(inDebugMode = true);
//  return inDebugMode;
 return false; //Para simular o crash em debugMode
}

/**
 * Catch and report Dart errors
 */
Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  if (isInDebugMode) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  print('Reporting to Sentry.io.');
  _sentryClient
      .captureException(
    exception: error,
    stackTrace: stackTrace,
  )
      .then((response) => loggingResponse(response));
}

/**
 * Custom Event
 */
Future<void> captureEvent({
  String eventId,
  String eventMessage,
}) async {
  print('captureEvent to Sentry.io.');


  String appVersion = kIsWeb ? "Web": "${Platform.version} - ${Platform.resolvedExecutable} - ${Platform.numberOfProcessors} - ${Platform.operatingSystem}";

  final Event event = await createEnv(
    isError: false,
    eventMessage: eventMessage,
    tags: {
      'app_version': appVersion,
      'eventId': eventId,
    },
  );

  await _sentryClient
      .capture(event: event)
      .then((response) => loggingResponse(response));
}

void loggingResponse(SentryResponse response) {
  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}

Future<SentryClient> createClient() async {

  String appVersion = kIsWeb ? "Web": "${Platform.version} - ${Platform.resolvedExecutable} - ${Platform.numberOfProcessors} - ${Platform.operatingSystem}";

  Event env = await createEnv(tags: {
    'app_version': "$appVersion",
  });

  return SentryClient(
    dsn: _dsn,
    environmentAttributes: env,
  );
}

Future<Event> createEnv({
  bool isError = true,
  String eventMessage,
  Map<String, String> tags,
}) async {
  final _contexts = await getContexts();
  final user = await _getUserClient();

  return Event(
    userContext: user,
    level: isError ? SeverityLevel.error : SeverityLevel.info,
    tags: tags,
    message: isError ? null : eventMessage,
    contexts: _contexts,
  );
}

Future<Contexts> getContexts() async {
  if (kIsWeb) {
    return Contexts(
        device: Device(
          model: "Web",
          manufacturer: "Web",
        ),
        app: App(
            version: 'Web', buildType: isInDebugMode ? 'debug' : 'release'));
  } else {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      print(
          'Android $release (SDK $sdkInt), $manufacturer $model'); // Android 9 (SDK 28), samsung SM-N976N

      return Contexts(
        device: Device(
          model: model,
          manufacturer: manufacturer,
        ),
        app: App(
            version: '$release (SDK $sdkInt)',
            buildType: isInDebugMode ? 'debug' : 'release'),
      );
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;

      print(
          '$systemName $version, $name ,$model'); // iOS 13.1, iPhone 11 Pro Max, iPhone

      return Contexts(
        device: Device(
          model: name,
          manufacturer: 'apple',
        ),
        app: App(
          version: version,
          buildType: isInDebugMode ? 'debug' : 'release',
        ),
      );
    } else {
      throw 'Not Supported OS';
    }
  }
}

//TODO: Adicionar mais coisa do usuário aqui
Future<User> _getUserClient() async {
  String id = kIsWeb ? "Web": "${Platform.numberOfProcessors}";

  return User(
id:id,
      email: "Desconhecido",

      extras: {});
}
