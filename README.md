### TODO:
- add persistence layer for SpendDay->[SpendItem]
  - only want to persist current month; OK to purge when new month starts
  - Note:
    - when deciding if is new month / to purge last month, can pull 1st SpendDay out of DB and check if month equals month of Date() (today)
      - tldr: purge last month if new month <-
- make spend items editable on row tap
- tend to TODO's
- tend to FIXME's
- build Widget
  - shows daily trends
  - has buttons for quick amounts ($5, $10, $20) and checkmark to save

resources:
- https://developer.apple.com/documentation/swiftdata
- https://developer.apple.com/documentation/swiftui/datepicker
- https://developer.apple.com/documentation/swiftui/environmentvalues
- https://www.swiftyplace.com/blog/swiftui-sheets-modals-bottom-sheets-fullscreen-presentation-in-ios
