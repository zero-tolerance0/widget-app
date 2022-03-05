//
//  Telemat_Widget.swift
//  Telemat Widget
//
//  Created by didarmarat on 26.01.2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
//    @AppStorage("telemat", store: UserDefaults(suiteName: "ru.dreamteam.telemat.Telemat-Widget"))
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), formatValue: "", deviceName: "", paramName: "", configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), formatValue: "", deviceName: "", paramName: "", configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let userDefaults = UserDefaults(suiteName: "group.ru.dreamteam.telemat")
        let formatValue = userDefaults?.value(forKey: "formatValue") as? String ?? ""
        let deviceName = userDefaults?.value(forKey: "deviceName") as? String ?? ""
        let paramName = userDefaults?.value(forKey: "paramName") as? String ?? ""
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, formatValue: formatValue, deviceName: deviceName, paramName: paramName, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let formatValue: String
    let deviceName: String
    let paramName: String
    let configuration: ConfigurationIntent
}

struct Telemat_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {

//        Text("Test Link")
//                    .widgetURL(URL(string: "telematapp://link"))
//        Text(entry.deviceName).onOpenURL(perform: { url in
//            Link(destination: URL(string: "telematapp://link"
////                string: "https://telemat.su/startios.html"
//            )!) {
                
        VStack(alignment: .center, spacing: 20, content: {
                Text(entry.deviceName)
                HStack(alignment: .center, spacing: 5, content: {
                    Text(entry.formatValue).font(Font.system(size: 50)).multilineTextAlignment(.center)
                        Image("Rhea").resizable().cornerRadius(25).frame(width: 20.0, height: 50.0)
                    })
            HStack {
                Text(entry.paramName)
                Text(",")
                Text("B")
            }
                }).widgetURL(URL(string: "telematapp://link"))
//            }
//        })
//        VStack(alignment: .center, spacing: 10){
//            Text(entry.deviceName)
//            HStack{
//                Text(entry.formatValue)
//            }
//            Text(entry.paramName)
//        }
    }
}

@main
struct Telemat_Widget: Widget {
    let kind: String = "Telemat_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Telemat_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Telemat_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Telemat_WidgetEntryView(entry: SimpleEntry(date: Date(), formatValue: "Hello Widget", deviceName: "Hello Widget", paramName: "Hello Widget", configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
