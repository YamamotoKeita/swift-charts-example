import SwiftUI
import Charts

struct BarChartExample: View {
    let barData: [Double] = [14195853, 4856476, 5977201, 4856476]

    var body: some View {
        Chart {
            ForEach(Array(barData.enumerated()), id: \.element) { timeIndex, number in
                BarMark(
                    x: .value("Category", "\(timeIndex)期"),
                    y: .value("Value", number)
                )
            }

        }
        .chartYAxis {
            AxisMarks(position: .leading, values: yAxis()) { axis in
                let value = yAxis()[axis.index]
                AxisGridLine()
                AxisValueLabel("\(Int(value / 10000))", centered: false)
            }
        }
        .frame(height: 300)
    }

    func yAxis() -> [Double] {
        guard let max = barData.max() else {
            return []
        }

        return YAxisUtil.calcYAxis(
            min: 0,
            max: max * 1.1,
            lineCount: 6,
            minSpan: 10
        )
    }
}

#Preview {
    BarChartExample()
}
