import SwiftUI
import Charts

struct ContentView: View {
    @State var selectedX: String? = nil

    let barChartData = [
        [90000, 65000, 80000],
        [30000, 50000, 55000],
        [40000, 80000, 70000]
    ]

    let lineChartData: [[Double]] = [
        [4, -1, -10],
        [8, 9, 7],
        [7, 10, 18]
    ]

    var body: some View {
        VStack {
            Text(selectedX ?? "")

            Chart {
                // Bar Chart
                ForEach(Array(barChartData.enumerated()), id: \.element) { dataIndex, data in
                    ForEach(Array(data.enumerated()), id: \.element) { timeIndex, number in
                        BarMark(
                            x: .value("Name", "\(timeIndex)期"),
                            y: .value("Value", number)
                        )
                        .foregroundStyle(by: .value("Category", "Bar\(dataIndex)"))
                        .position(by: .value("Category", "データ\(dataIndex)"))
                    }
                }

                // Line Chart
                ForEach(Array(lineChartData.enumerated()), id: \.element) { dataIndex, data in
                    ForEach(Array(data.enumerated()), id: \.element) { timeIndex, number in
                        LineMark(
                            x: .value("Name", "\(timeIndex)期"),
                            y: .value("Percentage\(dataIndex)", number)
                        )
                        .foregroundStyle(by: .value("Category", "Line\(dataIndex)"))
                        .symbol(by: .value("Category", "Category\(dataIndex)"))
                    }
                }
            }
            .chartForegroundStyleScale(
                [
                    "Line0": .orange,
                    "Line1": .pink,
                    "Line2": .teal,
                    "Bar0": .cyan,
                    "Bar1": .green,
                    "Bar2": .blue,
                ]
            )
            .chartYAxis {
                AxisMarks(
                    position: .leading,
                    values: .automatic(desiredCount: 5)
                )
                AxisMarks(
                    position: .trailing,
                    values: .automatic(desiredCount: 5)
                ) { axis in
                   AxisValueLabel("\(1014 + axis.index)", centered: false)
               }
            }
//            .chartYAxis {
//                AxisMarks(position: .leading, values: Array(stride(from: -24, through: 24, by: 30))){
//                    axis in
//                    AxisTick()
//                    AxisGridLine()
//                    AxisValueLabel("\(1014 + (axis.index * 1))", centered: false)
//                }
//                AxisMarks(position: .trailing, values: Array(stride(from: 0, through: 100, by: 30))){
//                    axis in
//                    AxisTick()
//                    AxisGridLine()
//                    AxisValueLabel("\(axis.index * 4)", centered: false)
//                }
//            }
            .chartYAxisLabel("(兆円)", position: .topLeading)
            .chartYAxisLabel("(%)", position: .topTrailing)
            .chartLegend(.hidden)
            .frame(height: 300)
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .onTapGesture { location in
                                onTap(
                                    proxy: proxy,
                                    location: location,
                                    geometry: geometry
                                )
                            }
                    }
                }
            }
        }
    }

    func onTap(proxy: ChartProxy, location: CGPoint, geometry: GeometryProxy) {
        let xPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        let xLabel: String? = proxy.value(atX: xPosition)
        selectedX = xLabel
    }
}

#Preview {
    ContentView()
}
