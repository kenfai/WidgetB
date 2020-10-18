//
//  WidgetView.swift
//  WidgetB
//
//  Created by Ginger on 17/10/2020.
//

import SwiftUI
import WidgetKit

struct WidgetData {
    let weight: Measurement<UnitMass>
    let date: Date
}

extension WidgetData {
    static let previewData = WidgetData(weight: Measurement<UnitMass>(value: 66.99, unit: .kilograms), date: Date().advanced(by: (-60*29)))
}

struct WidgetView: View {
    @Environment(\.widgetFamily) var widgetFamily
    
    let data: WidgetData
    
    var body: some View {
        ZStack {
            Color(.yellow)
            HStack {
                VStack(alignment: .leading) {
                    WeightView(data: data)
                    Spacer()
                    LastUpdatedView(data: data)
                }
                .padding(.all)
                if widgetFamily == .systemMedium {
                    Image("weight").resizable()
                }
            }
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            WidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            WidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

struct WeightView: View {
    let data: WidgetData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.body)
                    .foregroundColor(.purple)
                    .bold()
                
                Spacer()
                
                Text(MeasurementFormatter().string(from: data.weight))
                    .font(.title)
                    .foregroundColor(.purple)
                    .bold()
                    .minimumScaleFactor(0.9)
            }
            Spacer()
        }
        .padding(.all, 8)
        .background(ContainerRelativeShape().fill(Color(.cyan)))
    }
}

struct LastUpdatedView: View {
    let data: WidgetData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Last updated")
                .font(.body)
                .bold()
                .foregroundColor(.purple)
            Text("\(data.date, style: .relative) ago")
                .font(.caption)
                .foregroundColor(.purple)
        }
    }
}
