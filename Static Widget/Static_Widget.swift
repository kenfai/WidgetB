//
//  Static_Widget.swift
//  Static Widget
//
//  Created by Ginger on 17/10/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
        
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Static_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct Static_Widget: Widget {
    let kind: String = "Static_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            //Static_WidgetEntryView(entry: entry)
            WidgetView(data: .previewData)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Weight Display")
        .description("Your weight will be shown, as added in the app.")
    }
}

struct Static_Widget_Previews: PreviewProvider {
    static var previews: some View {
        //Static_WidgetEntryView(entry: SimpleEntry(date: Date()))
        WidgetView(data: .previewData)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
