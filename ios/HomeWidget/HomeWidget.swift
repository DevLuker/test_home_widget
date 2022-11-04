//
//  HomeWidget.swift
//  HomeWidget
//
//  Created by Sandro Delgadillo on 18/10/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), compra: "place", venta: "place2", configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), compra: "aea", venta: "aex",configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let data = UserDefaults.init(suiteName:"group.home.widget.demo")
        
        let compra = data?.string(forKey: "compra")
        let venta = data?.string(forKey: "venta")
        if(compra != nil && venta != nil){
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, compra: compra!, venta:venta!, configuration: configuration)
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }else{
            let entry = SimpleEntry(date: Date(), compra: "uwu", venta: "owo",configuration: configuration)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let compra: String
    let venta: String
    let configuration: ConfigurationIntent
}

struct HomeWidgetEntryView : View {
    var entry: Provider.Entry
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                    [
                        Color(
                            red: 0.0/255.0,
                            green: 0.0/255.0,
                            blue: 255.0/255.0
                        ),
                        Color(
                            red: 0.0/255.0,
                            green: 0.0/255.0,
                            blue: 138.0/255.0
                        )
                    ]
            ),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var defaultSpacer: some View = Spacer()
        .frame(minHeight: 10, maxHeight: 15)
    
    var logo: Image = Image("LogoRextie")
    
    //    var exchange: some View =
    
    var body: some View {
        GeometryReader() { geo in
            VStack(alignment: .leading) {
                defaultSpacer
                logo
                    .resizable()
                    .frame(
                        minWidth: 80,
                        maxWidth: 80,
                        minHeight: 26.33,
                        maxHeight: 26.33
                    )
                    .padding(.horizontal, 12)
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("Compra")
                            .font(.system(size: 12).weight(.light))
                            .foregroundColor(.white)
                            .frame(width: 50, alignment: .leading)
                        Spacer()
                        Text(entry.compra)
                            .font(.system(size: 12).weight(.bold))
                            .foregroundColor(.white).frame(width: 30)
                        Spacer()
                    }
                    .padding([.top], 10)
                    
                    //        Spacer()
                    //            .frame(maxHeight: 5)
                    HStack {
                        Spacer()
                        Text("Venta")
                            .font(.system(size: 12).weight(.light))
                            .foregroundColor(.white)
                            .frame(width: 50, alignment: .leading)
                        Spacer()
                        Text(entry.venta)
                            .font(.system(size: 12).weight(.bold))
                            .foregroundColor(.white).frame(width: 30)
                        Spacer()
                    }
                    .padding([.bottom], 10)
                }
                .background(
                    Color(
                        red: 255.0/255.0,
                        green: 255.0/255.0,
                        blue:  255.0/255.0,
                        opacity: 0.2
                    )
                )
                .cornerRadius(10)
                .padding(.horizontal, 12)
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Image("ChangeIcon")
                        .resizable()
                        .frame(
                            minWidth: 16,
                            maxWidth: 16,
                            minHeight: 16,
                            maxHeight: 16
                        )
                    Text("Hoy - 5:00 pm")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    Spacer()
                }
                defaultSpacer
            }
        }
        .background(gradient)
        
    }
}

@main
struct HomeWidget: Widget {
    let kind: String = "HomeWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            HomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct HomeWidget_Previews: PreviewProvider {
    static var previews: some View {
        HomeWidgetEntryView(entry:SimpleEntry(date: Date(), compra: "aea", venta: "venta", configuration: ConfigurationIntent() ))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
