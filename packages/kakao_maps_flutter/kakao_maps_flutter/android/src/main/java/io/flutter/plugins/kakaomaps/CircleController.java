// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.kakaomaps;

/** Controller of a single Circle on the map. */
class CircleController implements CircleOptionsSink {
  private final Circle circle;
  private final String kakaoMapsCircleId;
  private final float density;
  private boolean consumeTapEvents;

  CircleController(Circle circle, boolean consumeTapEvents, float density) {
    this.circle = circle;
    this.consumeTapEvents = consumeTapEvents;
    this.density = density;
    this.kakaoMapsCircleId = circle.getId();
  }

  void remove() {
    circle.remove();
  }

  @Override
  public void setConsumeTapEvents(boolean consumeTapEvents) {
    this.consumeTapEvents = consumeTapEvents;
    circle.setClickable(consumeTapEvents);
  }

  @Override
  public void setStrokeColor(int strokeColor) {
    circle.setStrokeColor(strokeColor);
  }

  @Override
  public void setFillColor(int fillColor) {
    circle.setFillColor(fillColor);
  }

  @Override
  public void setCenter(LatLng center) {
    circle.setCenter(center);
  }

  @Override
  public void setRadius(double radius) {
    circle.setRadius(radius);
  }

  @Override
  public void setVisible(boolean visible) {
    circle.setVisible(visible);
  }

  @Override
  public void setStrokeWidth(float strokeWidth) {
    circle.setStrokeWidth(strokeWidth * density);
  }

  @Override
  public void setZIndex(float zIndex) {
    circle.setZIndex(zIndex);
  }

  String getKakaoMapsCircleId() {
    return kakaoMapsCircleId;
  }

  boolean consumeTapEvents() {
    return consumeTapEvents;
  }
}
