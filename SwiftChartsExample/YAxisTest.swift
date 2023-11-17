import SwiftUI
import Charts

struct YAxisTest: View {

    let barData = [190000, 65000, 80000, 65000]
    let lineData = [-10, 8, 3, 5]

    var body: some View {
        Chart {
            // Bar Chart
            ForEach(Array(barData.enumerated()), id: \.element) { timeIndex, number in
                BarMark(
                    x: .value("Name", "\(timeIndex)期"),
                    y: .value("Bar", number),
                    width: 10
                )
                .foregroundStyle(Color.orange)
            }
            ForEach(Array(lineData.enumerated()), id: \.element) { timeIndex, number in
                LineMark(
                    x: .value("Name", "\(timeIndex)期"),
                    y: .value("Line", number)
                )
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: yAxisForBar())
            AxisMarks(position: .trailing, values: yAxisForBar()) { axis in
                let value = yAxisForLine()[axis.index]
                AxisValueLabel("\(Int(value))", centered: false)
            }
        }
        .chartYAxisLabel("(兆円)", position: .topLeading)
        .chartYAxisLabel("(%)", position: .topTrailing)
        .frame(height: 300)
    }

    func yAxisForLine() -> [Double] {
        guard let iMax = lineData.max(), let iMin = lineData.min() else {
            return []
        }
        let max = Double(iMax)
        let min = Double(iMin)

        let range = if max == min {
            10.0
        } else {
            max - min
        }

        let marginedMin = min - (range * 0.1)
        let marginedMax = max + (range * 0.1)

        let minInterval = (marginedMax - marginedMin) / 5
        let size = String(Int(minInterval)).count
        let suffix = pow(10.0, Double(size) - 2)
        let base = ceil(minInterval / suffix)
        let units: [Double] = [10, 12, 15, 20, 25, 30, 40, 50, 60, 80, 100]
        let unit = units.first {
            $0 >= base
        } ?? units.last!

        let interval = round(unit * suffix)
        let remainder = marginedMin.truncatingRemainder(dividingBy: interval)
        let graphMin = (marginedMin - remainder) - interval
        // TODO 多分マイナスの場合とプラスの場合で場合わけ
        print("\(marginedMin) \(remainder) \(interval)")

        return (0...5).map {
            graphMin + (Double($0) * interval)
        }
    }

//    func canContain(interval: Double, min: Double, max: Double) -> Bool {
//        
//    }

    func yAxisForBar() -> [Double] {
        guard let max = barData.max() else {
            return []
        }

        return yAxis(min: 0, max: Double(max) * 1.1)
    }

    func yAxis(min: Double, max: Double) -> [Double] {
        let interval = calcInterval(min: min, max: max)
        return (0...5).map {
            min + (Double($0) * interval)
        }
    }

    func calcInterval(min: Double, max: Double) -> Double {
        let units: [Double] = [10, 12, 15, 20, 25, 30, 40, 50, 60, 80, 100]

        let range = max - min
        let minInterval = range / 5
        let size = String(Int(minInterval)).count
        // TODO sizeが3以下のときの考慮
        let suffix = pow(10.0, Double(size) - 2)
        let base = ceil(minInterval / suffix)
        let unit = units.first { $0 >= base } ?? units.last!
        let interval = round(unit * suffix)

        return interval
    }
}

#Preview {
    YAxisTest()
}
