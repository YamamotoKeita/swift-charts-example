import SwiftUI
import Charts

struct BarChartExample: View {
    let barData: [Double] = [14195853, 4856476, 5977201, 4856476]
    @State var yAxis: [Double] = []

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
            AxisMarks(position: .leading, values: yAxis) { axis in
                let value = yAxis[axis.index]
                AxisGridLine()
                AxisValueLabel("\(Int(value / 10000))", centered: false)
            }
        }
        .frame(height: 300)
        .onAppear {
            yAxis = calcYAxis()
        }
    }

    func calcYAxis() -> [Double] {
        guard let max = barData.max() else {
            return []
        }

        return YAxisUtil.calcYAxis(
            min: 0,
            max: max * 1.1,
            divideCount: 5,
            defaultSpan: 10,
            forcePositive: true
        )
    }
}

#Preview {
    BarChartExample()
}
