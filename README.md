### TODO:
- add persistence layer for SpendDay->[SpendItem]
  - only want to persist current month; OK to purge when new month starts
  - Note:
    - when deciding if is new month / to purge last month, can pull 1st SpendDay out of DB and check if month equals month of Date() (today)
      - tldr: purge last month if new month <-
- tend to TODO's
- tend to FIXME's
- audit everything
- build Widget
  - shows daily trends
  - has buttons for quick amounts ($5, $10, $20) and checkmark to save

resources:
- https://developer.apple.com/documentation/swiftdata
- https://developer.apple.com/design/human-interface-guidelines/widgets
- https://developer.apple.com/documentation/WidgetKit
- https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension