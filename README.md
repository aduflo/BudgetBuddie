### TODO:
- modal for when new month starts:
    - 1) a month spend summary screen that pops at a new month to give overview of previous month
    - 2) an always accessible MonthsOverview/MonthsSummary view, that shows the total spend of each month compared to monthly allowance
        - needs Model persisted; fields of `spend` and `allowance`
            - field values come from the time of persistence (specifically talking about allowance). we want to persist each months allowance and reflect this nuance in the UI
- new user experience; explains intent and usage
- currency dropdown; USD, CAD…
    - Need to add notification and have appropriate views react
- add more tests
- add LaunchScreen
- build Widget
  - shows daily trends
  - has buttons for quick amounts ($5, $10, $20) and checkmark to save
- re-up Apple Dev for distribution, setup with FireBase (app distribution + crashlytics)

resources:
- https://developer.apple.com/design/human-interface-guidelines/widgets
- https://developer.apple.com/documentation/WidgetKit
- https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension
- https://developer.apple.com/documentation/widgetkit/building_widgets_using_widgetkit_and_swiftui
- https://developer.apple.com/design/human-interface-guidelines/typography