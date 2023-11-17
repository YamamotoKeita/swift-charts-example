import SwiftUI
import Charts

struct DoubleYAxis: View {

    @StateObject var viewModel = DoubleYAxisViewModel()

    var body: some View {
        VStack(spacing: 30) {
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
                AxisMarks(position: .leading, values: viewModel.yAxisForBar) { axis in
                    let value = viewModel.yAxisForBar[axis.index]
                    AxisGridLine()
                    AxisValueLabel("\(Int(value / 10000))", centered: false)
                }
                AxisMarks(position: .trailing, values: viewModel.yAxisForBar) { axis in
                    let value = viewModel.yAxisForLine[axis.index]
                    AxisValueLabel("\(Int(value))", centered: false)
                }
            }
            .chartYAxisLabel("(万円)", position: .topLeading)
            .chartYAxisLabel("(%)", position: .topTrailing)
            .frame(height: 300)

            Slider(value: $viewModel.sliderValue, in: 1...100)

            Text(viewModel.barSource.map { String($0) }.joined(separator: ", "))
            
            Text(viewModel.lineSource.map { String($0) }.joined(separator: ", "))

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    DoubleYAxis()
}
