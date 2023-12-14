import SwiftUI
import Charts

struct AxisFontExample: View {

    let data: [[Double]] = [
        [1, 2, 3],
        [-4, 0, 1],
        [2, 0, -1],
    ]

    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.offset) { dataIndex, records in
                ForEach(Array(records.enumerated()), id: \.offset) { timeIndex, number in
                    LineMark(
                        x: .value("FiscalYear", "\(timeIndex)期"),
                        y: .value("Line", number)
                    )
                    .foregroundStyle(by: .value("Category", "Line\(dataIndex)"))
                }
            }
        }
        .chartYAxis {
            AxisMarks {
                AxisGridLine()
                AxisValueLabel {
                    Text("XV")
                        .foregroundStyle(.red)
                }
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom, values: .stride(by: .hour, count: 2)) {
                _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel {
                    Text("XV")
                        .foregroundStyle(.red)
                }
            }
        }
        .frame(height: 300)
    }
}

#Preview {
    AxisFontExample()
}
