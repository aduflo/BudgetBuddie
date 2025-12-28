### TODO:
- add model for SpendDay
- add model for SpendItem
- add persistence layer for SpendDay->[SpendItem]
  - only want to persist current month; OK to purge when new month starts
- add calendar scroller for day picking; refresh on day selection
  - make sure on spend item creation, it gets mapped to today instead of selectedDate
- tend to TODO's
- tend to FIXME's
- build Widget
  - shows daily trends
  - has buttons for quick amounts ($5, $10, $20) and checkmark to add

resources:
- https://developer.apple.com/documentation/swiftdata
- https://developer.apple.com/documentation/swiftui/datepicker
- https://developer.apple.com/documentation/swiftui/environmentvalues
- https://www.swiftyplace.com/blog/swiftui-sheets-modals-bottom-sheets-fullscreen-presentation-in-ios



// notes
- when deciding if is new month / to purge last month, can pull 1st SpendDay out of DB and check if month equals month of Date() (today)
  - purge last month if new month <-