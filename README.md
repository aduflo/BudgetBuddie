### TODO:
- modal for when new month starts:
    - 1) a month spend summary screen that pops at a new month to give overview of previous month
    - 2) a always accessible MonthsOverview/MonthsSummary view, that shows the total spend of each month compared to our monthly allowance
        - Might create confusion tbh, since monthly allowance can change and these would be static numbers
            - Unless we hold onto what the monthly allowance was at_the_time?
        - Would require a new data model object that we persist before purging the store
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