import SwiftUI
import Charts

struct LineChartExample: View {
    @State private var sliderValue: Double = 1

    let baseData: [Double] = [-10, 20]

    var lineData: [Double] {
        baseData.map {
            $0 * sliderValue + sliderValue
        }
    }

    var body: some View {
        VStack(spacing: 50) {
            Chart {
                ForEach(Array(lineData.enumerated()), id: \.element) { timeIndex, number in
                    LineMark(
                        x: .value("Name", "\(timeIndex)期"),
                        y: .value("Line", number)
                    )
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: yAxisForLine())
            }
            .frame(height: 300)

            Slider(value: $sliderValue, in: 1...100)

            Text(lineData.map { String($0) }.joined(separator: ", "))
        }
        .padding(.horizontal, 20)
    }

    func yAxisForLine() -> [Double] {
        guard let max = lineData.max(), let min = lineData.min() else {
            return []
        }

        let range = max - min
        let marginedMax = max + (range * 0.1)
        return YAxisUtil.calcYAxis(
            min: min,
            max: marginedMax,
            lineCount: 6,
            minSpan: 10
        )
    }
}

#Preview {
    LineChartExample()
}
