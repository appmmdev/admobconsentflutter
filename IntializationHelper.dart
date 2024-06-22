import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class IntializationHelper {
  Future<FormError?> intialize() {
    final completer = Completer<FormError?>();

    final params = ConsentRequestParameters(
        consentDebugSettings: ConsentDebugSettings(
            // debugGeography: DebugGeography.debugGeographyNotEea,
            //
            debugGeography: DebugGeography.debugGeographyEea,
            testIdentifiers: [
          '5352961EB7A3EB18E129296F16AE3207', // your testIdentifiers for test
          'EB9BBC5BD77D0D1B7784DEECE361F265',// your testIdentifiers for test
          'B08A7B4D8ACC3035224D2C173018813B'// your testIdentifiers for test
        ]));
    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        await _loadConsentForm();
      } else {
        await _initialize();
      }

      completer.complete();
    }, (error) {
      completer.complete(error);
    });

    return completer.future;
  }

  Future<FormError?> _loadConsentForm() {
    final completer = Completer<FormError?>();

    ConsentForm.loadConsentForm((consentForm) async {
      final status = await ConsentInformation.instance.getConsentStatus();

      if (status == ConsentStatus.required) {
        consentForm.show((formError) {
          completer.complete(_loadConsentForm());
        });
      } else {
        await _initialize();
        completer.complete();
      }
    }, (formError) {
      completer.complete(formError);
    });

    return completer.future;
  }

  Future<void> _initialize() async {
    await MobileAds.instance.initialize();
  }
}
