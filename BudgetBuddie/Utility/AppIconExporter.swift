//
//  AppIconExporter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/28/26.
//

import SwiftUI

enum AppIconExporter {
    static func printPath() {
        // Inspiration: https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-swiftui-view-to-a-pdf
        
        // 1: Render content
        let renderer = ImageRenderer(
            content: AppIcon()
        )
        
        // 2: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: "app_icon.pdf")
        
        // 3: Start the rendering process
        renderer.render { (size, context) in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect(
                x: 0,
                y: 0,
                width: size.width,
                height: size.height
            )
            
            // 5: Create the CGContext for our PDF pages
            let pdf = CGContext(
                url as CFURL,
                mediaBox: &box,
                nil
            )
            guard let pdf else {
                return
            }
            
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        let path = url.path()
        print("Path to app icon: \(path))")
    }
}
