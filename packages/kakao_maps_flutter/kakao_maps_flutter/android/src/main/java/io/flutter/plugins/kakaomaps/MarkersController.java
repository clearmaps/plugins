// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.kakaomaps;

import android.util.Log;

import com.naver.maps.geometry.LatLng;
import com.naver.maps.map.KakaoMap;
import com.naver.maps.map.overlay.Marker;
import com.naver.maps.model.MarkerOptions;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

class MarkersController {

    private final Map<String, MarkerController> markerIdToController;
    private final Map<String, String> kakaoMapsMarkerIdToDartMarkerId;
    private final MethodChannel methodChannel;
    private KakaoMap kakaoMap;

    MarkersController(MethodChannel methodChannel) {
        this.markerIdToController = new HashMap<>();
        this.kakaoMapsMarkerIdToDartMarkerId = new HashMap<>();
        this.methodChannel = methodChannel;
    }

    void setKakaoMap(KakaoMap kakaoMap) {
        this.kakaoMap = kakaoMap;
    }

    void addMarkers(List<Object> markersToAdd) {
        if (markersToAdd != null) {
            for (Object markerToAdd : markersToAdd) {
                addMarker(markerToAdd);
            }
        }
    }

    void changeMarkers(List<Object> markersToChange) {
        if (markersToChange != null) {
            for (Object markerToChange : markersToChange) {
                changeMarker(markerToChange);
            }
        }
    }

    void removeMarkers(List<Object> markerIdsToRemove) {
        if (markerIdsToRemove == null) {
            return;
        }
        for (Object rawMarkerId : markerIdsToRemove) {
            if (rawMarkerId == null) {
                continue;
            }
            String markerId = (String) rawMarkerId;
            final MarkerController markerController = markerIdToController.remove(markerId);
            if (markerController != null) {
                markerController.remove();
                kakaoMapsMarkerIdToDartMarkerId.remove(markerController.getKakaoMapsMarkerId());
            }
        }
    }

    void showMarkerInfoWindow(String markerId, MethodChannel.Result result) {
        MarkerController markerController = markerIdToController.get(markerId);
        if (markerController != null) {
            markerController.showInfoWindow();
            result.success(null);
        } else {
            result.error("Invalid markerId", "showInfoWindow called with invalid markerId", null);
        }
    }

    void hideMarkerInfoWindow(String markerId, MethodChannel.Result result) {
        MarkerController markerController = markerIdToController.get(markerId);
        if (markerController != null) {
            markerController.hideInfoWindow();
            result.success(null);
        } else {
            result.error("Invalid markerId", "hideInfoWindow called with invalid markerId", null);
        }
    }

    void isInfoWindowShown(String markerId, MethodChannel.Result result) {
        MarkerController markerController = markerIdToController.get(markerId);
        if (markerController != null) {
            result.success(markerController.isInfoWindowShown());
        } else {
            result.error("Invalid markerId", "isInfoWindowShown called with invalid markerId", null);
        }
    }

    boolean onMarkerTap(String googleMarkerId) {
        String markerId = kakaoMapsMarkerIdToDartMarkerId.get(googleMarkerId);
        if (markerId == null) {
            return false;
        }
        methodChannel.invokeMethod("marker#onTap", Convert.markerIdToJson(markerId));
        MarkerController markerController = markerIdToController.get(markerId);
        if (markerController != null) {
            return markerController.consumeTapEvents();
        }
        return false;
    }

    void onMarkerDragEnd(String googleMarkerId, LatLng latLng) {
        String markerId = kakaoMapsMarkerIdToDartMarkerId.get(googleMarkerId);
        if (markerId == null) {
            return;
        }
        final Map<String, Object> data = new HashMap<>();
        data.put("markerId", markerId);
        data.put("position", Convert.latLngToJson(latLng));
        methodChannel.invokeMethod("marker#onDragEnd", data);
    }

    void onInfoWindowTap(String googleMarkerId) {
        String markerId = kakaoMapsMarkerIdToDartMarkerId.get(googleMarkerId);
        if (markerId == null) {
            return;
        }
        methodChannel.invokeMethod("infoWindow#onTap", Convert.markerIdToJson(markerId));
    }

    private void addMarker(Object marker) {
        if (marker == null) {
            return;
        }
        MarkerBuilder markerBuilder = new MarkerBuilder();
        String markerId = Convert.interpretMarkerOptions(marker, markerBuilder);
        MarkerOptions options = markerBuilder.build();
        addMarker(markerId, options, markerBuilder.consumeTapEvents());
    }

    private void addMarker(String markerId, MarkerOptions markerOptions, boolean consumeTapEvents) {
        Log.d("MarkersController", "[addMarker] --------------- " + markerId);

        final Marker marker = new Marker();
        marker.setPosition(markerOptions.getPosition());
        marker.setMap(kakaoMap);

        String naverMarkerId = Integer.toString(marker.hashCode());
        MarkerController controller = new MarkerController(marker, consumeTapEvents);
        markerIdToController.put(markerId, controller);
        kakaoMapsMarkerIdToDartMarkerId.put(naverMarkerId, markerId);
        marker.setOnClickListener(overlay -> onMarkerTap(naverMarkerId));
    }

    private void changeMarker(Object marker) {
        if (marker == null) {
            return;
        }
        String markerId = getMarkerId(marker);
        MarkerController markerController = markerIdToController.get(markerId);
        if (markerController != null) {
            Convert.interpretMarkerOptions(marker, markerController);
        }
    }

    @SuppressWarnings("unchecked")
    private static String getMarkerId(Object marker) {
        Map<String, Object> markerMap = (Map<String, Object>) marker;
        return (String) markerMap.get("markerId");
    }
}
