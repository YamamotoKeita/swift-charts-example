import SwiftUI
import Charts

struct DoubleYAxis: View {

    @StateObject var viewModel = DoubleYAxisViewModel()

    var body: some View {
        Chart {
            // Bar Chart
            ForEach(Array(viewModel.barData.enumerated()), id: \.element) { timeIndex, number in
                BarMark(
                    x: .value("Name", "\(timeIndex)期"),
                    y: .value("Bar", number),
                    width: 10
                )
                .foregroundStyle(Color.orange)
            }
            ForEach(Array(viewModel.lineData.enumerated()), id: \.element) { timeIndex, number in
                LineMark(
                    x: .value("Name", "\(timeIndex)期"),
                    y: .value("Line", number)
                )
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: viewModel.yAxisForBar)
            AxisMarks(position: .trailing, values: viewModel.yAxisForBar) { axis in
                let value = viewModel.yAxisForLine[axis.index]
                AxisValueLabel("\(Int(value))", centered: false)
            }
        }
        .chartYAxisLabel("(兆円)", position: .topLeading)
        .chartYAxisLabel("(%)", position: .topTrailing)
        .frame(height: 300)
    }
}

#Preview {
    DoubleYAxis()
}
