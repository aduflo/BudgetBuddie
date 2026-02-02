### TODO:
Before RC:
- fix layout on spend history; diff number, when biggg and negative, dropped newline
- fix bug where no selected day on initial load :(
- think about extending SpendRepositoryError usage in SpendRepo, given bunch of SpendStoreError's will bubble up; no do/catch around trys
- tend to TODOs
- test additions
- QA + find bugs
- cut 1.0 RC

Feature backlog:
- widget
  - shows daily trends
  - has buttons for quick amounts ($5, $10, $20) and checkmark to save
- currency dropdown; USD, CAD…
  - Need to add notification and have appropriate views react
- add notion of Category to SpendItem
  - update model
  - update SpendItemView to have dropdown selector

### Resources:
// widgets
- https://developer.apple.com/design/human-interface-guidelines/widgets
- https://developer.apple.com/documentation/WidgetKit
- https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension
- https://developer.apple.com/documentation/widgetkit/building_widgets_using_widgetkit_and_swiftui

// app icon
- https://developer.apple.com/design/human-interface-guidelines/app-icons#Specifications
- https://developer.apple.com/documentation/xcode/creating-your-app-icon-using-icon-composer/

// misc.
- https://developer.apple.com/design/human-interface-guidelines/typography
- https://stackoverflow.com/questions/57988687/how-to-use-dark-mode-in-ios-simulator