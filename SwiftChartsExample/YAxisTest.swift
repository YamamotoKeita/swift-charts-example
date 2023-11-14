import SwiftUI
import Charts

struct YAxisTest: View {

    let barChartData = [190000, 65000, 80000]

    var body: some View {
        Chart {
            // Bar Chart
            ForEach(Array(barChartData.enumerated()), id: \.element) {timeIndex, number in
                BarMark(
                    x: .value("Name", "\(timeIndex)期"),
                    y: .value("Value", number)
                )
            }
        }
        .chartYAxis {
            AxisMarks(values:  yAxisValues())
        }
    }

    func yAxisValues() -> [Int] {
        guard let max = barChartData.max() else {
            return []
        }

        let interval = calcInterval(maxValue: max)
        return (0...5).map { $0 * interval }
    }

    func calcInterval(maxValue: Int) -> Int {
        let units = [10, 12, 15, 20, 25, 30, 40, 50, 60, 80]

        let marginedMax = Double(maxValue) * 1.1
        let minInterval = marginedMax / 5
        let size = String(Int(minInterval)).count
        let suffix = pow(10.0, Double(size) - 2)
        let base = ceil(minInterval / suffix)
        let unit = units.first { Double($0) >= base } ?? units[0]
        let interval = round(Double(unit) * suffix)
        
        return Int(interval)
    }
}

#Preview {
    YAxisTest()
}
