# nzdoc_maps_mobile

Mobile application using the NZ Department of Conservation data to show a map of campsites, tracks and others, similar to the existing website [DOC maps: Discover the outdoors](https://www.doc.govt.nz/map/index.html).

It has offline support so the user can access the maps without network. Data is embedded in the mobile app as JSON files.

## Getting Started

1. Add your Google Maps API Key to the projects like described in this course: https://developers.google.com/maps/flutter-package/config?hl=fr#step_4_add_your_api_key_to_the_project
2. Run app `flutter run`

## Build json_annotation

```
dart run build_runner build
```

## Colors

- Icon blue : #29629F
- Selected marker : BG #d7503f - Border #a3251b
- Walking route : #EA3322
