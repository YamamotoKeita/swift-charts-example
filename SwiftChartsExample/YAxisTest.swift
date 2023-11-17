import SwiftUI
import Charts

struct YAxisTest: View {
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
    YAxisTest()
}

enum YAxisUtil {
    static private let units: [Double] = [10, 12, 15, 20, 25, 30, 40, 50, 60, 80]

    static func calcYAxis(min: Double, max: Double, lineCount: Int, minSpan: Double) -> [Double] {
        var safeMin = min
        var safeMax = max
        if min == max {
            safeMin = min - minSpan / 2
            safeMax = max + minSpan / 2
        }

        let lowerLimit = (safeMax - safeMin) / (Double(lineCount) - 1)
        let length = String(Int(lowerLimit)).count
        let suffix = pow(10.0, Double(length) - 2)
        let prefix = ceil(lowerLimit / suffix)

        var unitScale: Double = 1
        var unitIndex = 0
        let proceedUnitIndex = {
            if unitIndex < units.count - 1 {
                unitIndex += 1
            } else {
                unitScale *= 10
                unitIndex = 0
            }
        }

        var interval: Double = 0
        var graphMax: Double = 0
        while true {
            let unit = units[unitIndex] * unitScale
            if unit < prefix {
                proceedUnitIndex()
                continue
            }

            interval = unit * suffix
            let remainder = safeMax.truncatingRemainder(dividingBy: interval)

            graphMax = safeMax - remainder
            if 0 < remainder {
                graphMax += interval
            }

            let graphMin = graphMax - interval * (Double(lineCount) - 1)
            if safeMin > graphMin {
                break
            }
            proceedUnitIndex()
        }

        return (0..<lineCount)
            .reversed()
            .map {
                graphMax - (Double($0) * interval)
            }
    }
}
