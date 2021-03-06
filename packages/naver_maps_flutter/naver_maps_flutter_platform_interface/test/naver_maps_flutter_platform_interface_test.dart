// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mockito/mockito.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:naver_maps_flutter_platform_interface/src/method_channel/method_channel_naver_maps_flutter.dart';
import 'package:naver_maps_flutter_platform_interface/naver_maps_flutter_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$NaverMapsFlutterPlatform', () {
    test('$MethodChannelNaverMapsFlutter() is the default instance', () {
      expect(NaverMapsFlutterPlatform.instance,
          isInstanceOf<MethodChannelNaverMapsFlutter>());
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        NaverMapsFlutterPlatform.instance =
            ImplementsNaverMapsFlutterPlatform();
      }, throwsA(isInstanceOf<AssertionError>()));
    });

    test('Can be mocked with `implements`', () {
      final NaverMapsFlutterPlatformMock mock =
      NaverMapsFlutterPlatformMock();
      NaverMapsFlutterPlatform.instance = mock;
    });

    test('Can be extended', () {
      NaverMapsFlutterPlatform.instance = ExtendsNaverMapsFlutterPlatform();
    });
  });

  group('$MethodChannelNaverMapsFlutter', () {
    const MethodChannel channel =
    MethodChannel('plugins.clearmaps.io/naver_maps_flutter');
    final List<MethodCall> log = <MethodCall>[];
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
    });

//    final MethodChannelNaverMapsFlutter map = MethodChannelNaverMapsFlutter(0);

    tearDown(() {
      log.clear();
    });

    test('foo', () async {
//      await map.foo();
      expect(
        log,
        <Matcher>[],
      );
    });
  });
}

class NaverMapsFlutterPlatformMock extends Mock
    with MockPlatformInterfaceMixin
    implements NaverMapsFlutterPlatform {}

class ImplementsNaverMapsFlutterPlatform extends Mock
    implements NaverMapsFlutterPlatform {}

class ExtendsNaverMapsFlutterPlatform extends NaverMapsFlutterPlatform {}