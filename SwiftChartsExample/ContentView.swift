import SwiftUI
import Charts

struct ContentView: View {
    let barColors: [Color] = [
        .red,
        .cyan,
        .blue
    ]

    let barChartData = [
        [90, 65, 80],
        [30, 50, 55],
        [40, 80, 70]
    ]

    let lineChartData: [[Double]] = [
        [4, -1, -10],
        [8, 9, 7],
        [7, 10, 18]
    ]

    var body: some View {
        Chart {
            // Bar Chart
            ForEach(Array(barChartData.enumerated()), id: \.element) { dataIndex, data in
                ForEach(Array(data.enumerated()), id: \.element) { timeIndex, number in
                    BarMark(
                        x: .value("Name", "\(timeIndex)期"),
                        y: .value("Value", number)
                    )
                    .foregroundStyle(by: .value("Category", "Bar\(dataIndex)"))
//                    .foregroundStyle(barColors[dataIndex])
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
//        .chartForegroundStyleScale([
//            "Category0": .yellow,
//            "Category1": .purple,
//            "Category2": .teal
//        ])
        .chartYAxis {
            AxisMarks(position: .leading, values: Array(stride(from: -24, through: 24, by: 30))){
                axis in
                AxisTick()
                AxisGridLine()
                AxisValueLabel("\(1014 + (axis.index * 1))", centered: false)
            }
            AxisMarks(position: .trailing, values: Array(stride(from: 0, through: 100, by: 30))){
                axis in
                AxisTick()
                AxisGridLine()
                AxisValueLabel("\(axis.index * 4)", centered: false)
            }
        }
//        .chartLegend(.hidden)
        .frame(height: 300)
        .chartOverlay { proxy in
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .onTapGesture { location in
                            let xPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
                            let xLabel: String? = proxy.value(atX: xPosition)
                            print(xLabel ?? "nil")
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
