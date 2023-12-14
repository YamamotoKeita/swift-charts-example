import SwiftUI
import Charts

struct LineMarkExample: View {

    let data: [[Double]] = [
        [1, 2, 3],
        [-4, 0, 1],
        [2, 0, -1],
    ]

    let colorMap: KeyValuePairs<String, Color> = [
        "Line0": Color.red,
        "Line1": Color.blue,
        "Line2": Color.green,
    ]

    var body: some View {
        VStack(spacing: 50) {
            Chart {

                ForEach(Array(data.enumerated()), id: \.offset) { dataIndex, records in
                    ForEach(Array(records.enumerated()), id: \.offset) { timeIndex, number in
                        LineMark(
                            x: .value("FiscalYear", "\(timeIndex)期"),
                            y: .value("Line", number)
                        )
                        .foregroundStyle(by: .value("Category", "Line\(dataIndex)"))
                        .symbol {
                            Circle()
                                .fill(.white)
                                .stroke(.yellow, lineWidth: 2)
                                .frame(width: 8)
                        }
                    }
                }
            }
            .chartForegroundStyleScale(colorMap)
            .frame(height: 300)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    LineMarkExample()
}
