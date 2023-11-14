import Charts
import SwiftUI
import WeatherKit

struct TwoAxisExample: View {

    var body: some View {
        Chart {
            ForEach(hours, id: \.date) {
                LineMark(
                    x: .value("Date", $0.date, unit: .hour),
                    y: .value("Wind Speed", $0.windSpeed)
                )
                .foregroundStyle(by: .value("Value", "Wind"))

                LineMark(
                    x: .value("Date", $0.date, unit: .hour),
                    y: .value("Pressure", ($0.pressure - 1014) * 4)
                )
                .foregroundStyle(by: .value("Value", "Pressure"))
            }
            .lineStyle(StrokeStyle(lineWidth: 4.0))
            .interpolationMethod(.catmullRom)
        }
        .chartForegroundStyleScale([
            "Pressure": .purple,
            "Wind": .teal
        ])
        .chartXAxis {
            AxisMarks(position: .bottom, values: .stride(by: .hour, count: 2)) {
                _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.hour(), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: Array(stride(from: 0, through: 24, by: 4))){
                axis in
                AxisTick()
                AxisGridLine()
                AxisValueLabel("\(1014 + (axis.index * 1))", centered: false)
            }
            AxisMarks(position: .trailing, values: Array(stride(from: 0, through: 24, by: 4))){
                axis in
                AxisTick()
                AxisGridLine()
                AxisValueLabel("\(axis.index * 4)", centered: false)
            }
        }
        .chartYAxisLabel("(円)", position: .topLeading)
        .chartYAxisLabel("(ドル)", position: .topTrailing)
    }
}


#Preview {
    TwoAxisExample()
}

struct HourWeatherStruct {
    var date: Date
    var pressure: Double
    var temperature: Double
    var windSpeed: Double
}

let hours: [HourWeatherStruct] = [
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600),
                      pressure: 1015.0,
                      temperature: 18.2,
                      windSpeed: 6.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 2),
                      pressure: 1015.3,
                      temperature: 18.2,
                      windSpeed: 8.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 3),
                      pressure: 1015.9,
                      temperature: 18.2,
                      windSpeed: 9.4),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 4),
                      pressure: 1016.3,
                      temperature: 18.2,
                      windSpeed: 5.2),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 5),
                      pressure: 1016.3,
                      temperature: 18.2,
                      windSpeed: 12.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 6),
                      pressure: 1016.3,
                      temperature: 18.2,
                      windSpeed: 11.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 7),
                      pressure: 1017.3,
                      temperature: 18.2,
                      windSpeed: 10.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 8),
                      pressure: 1018.3,
                      temperature: 18.2,
                      windSpeed: 11.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 9),
                      pressure: 1018.3,
                      temperature: 18.2,
                      windSpeed: 9.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 10),
                      pressure: 1018.3,
                      temperature: 18.2,
                      windSpeed: 8.1),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 11),
                      pressure: 1017.3,
                      temperature: 18.2,
                      windSpeed: 19.9),
    HourWeatherStruct(date: Date(timeIntervalSinceNow: 3600 * 12),
                      pressure: 1018.3,
                      temperature: 18.2,
                      windSpeed: 7.1),
]
