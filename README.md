### TODO:
Before RC:
- fix up for dark mode
  - backgrounds are good now. just need to visit every Text() to give it an applicable .foregroundStyle(.??)
  - audit every screen
    - onboarding view
    - home view
    - month summary view
    - history view
    - settings view
    - spend item view
- test additions
- QA + find bugs
- cut 1.0 RC

Feature backlog:
- widget
  - shows daily trends
  - has buttons for quick amounts ($5, $10, $20) and checkmark to save
- add notion of Category to SpendItem
  - update model
  - update SpendItemView to have dropdown selector
- currency dropdown; USD, CAD…
    - Need to add notification and have appropriate views react

### Resources:
// widgets
- https://developer.apple.com/design/human-interface-guidelines/widgets
- https://developer.apple.com/documentation/WidgetKit
- https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension
- https://developer.apple.com/documentation/widgetkit/building_widgets_using_widgetkit_and_swiftui

// app icon
- https://developer.apple.com/design/human-interface-guidelines/app-icons#Specifications
- https://developer.apple.com/documentation/xcode/creating-your-app-icon-using-icon-composer/
- https://cloudconvert.com/pdf-to-png

// misc.
- https://developer.apple.com/design/human-interface-guidelines/typography
- https://stackoverflow.com/questions/57988687/how-to-use-dark-mode-in-ios-simulator