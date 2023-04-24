//
//  ContentView.swift
//  EmmaKadai12
//
//  Created by Emma
//

import SwiftUI

struct ContentView: View {
    @State var taxExcludedAmountInput: String = ""
    @State var taxRateInput: String = ""
    @State var taxIncludingAmountNumber: Double = 0
    @AppStorage("TaxRate") var taxRate: Int = 0

    var body: some View {
        VStack(spacing: 10){
            Text("課題12\n税込金額を計算するアプリ")
                .font(.headline)
            Text("消費税率は保存される")
                .font(.subheadline)
                .padding(.bottom, 40)

            Grid(alignment: .trailing, horizontalSpacing: 10, verticalSpacing: 10) {
                GridRow {
                    Text("税抜金額")
                        .padding(.leading, 30)
                    TextField("", text: $taxExcludedAmountInput)
                        .modifier(TextMyStyle())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    Text("円")
                        .padding(.trailing, 30)
                        .gridColumnAlignment(.leading)
                }
                GridRow {
                    Text("消費税率")
                    TextField("", text: $taxRateInput)
                        .modifier(TextMyStyle())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    Text("%")
                }
                GridRow{
                    Button(action: {
                        // Doubleにできなければ0
                        let taxExcludedAmountNumber = Double(taxExcludedAmountInput) ?? 0
                        let taxRateNumber = Double(taxRateInput) ?? 0

                        //税込金額を計算
                        taxIncludingAmountNumber = taxExcludedAmountNumber * (1 + (taxRateNumber * 0.01))
                        // 税率をAppStrageに入れる
                        taxRate = Int(taxRateNumber)
                    })
                    {
                        Text("計算")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(width: 80)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.teal))
                    }
                    .gridCellColumns(3)
                    .frame(maxWidth:.infinity, alignment: .center)

                }
                GridRow{
                    Text("税込金額")
                    Text("\(Int(taxIncludingAmountNumber))")
                        .modifier(TextMyStyle())
                    Text("円")
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.teal.opacity(0.2))
                    .padding(.horizontal, 40)
                    .padding(.vertical, -20)
            )
            
            //            Text("TaxRate: \(UserDefaults.standard.integer(forKey: "TaxRate"))").padding(.top, 50)

            Spacer()
                .onAppear{
                    taxRateInput = String(Int(taxRate))
                }
        }
        .padding()
    }
}

struct TextMyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(width: 180, alignment: .trailing)
            .background(RoundedRectangle(cornerRadius: 10).fill(.teal.opacity(0.2)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
