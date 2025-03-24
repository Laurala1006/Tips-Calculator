import SwiftUI

struct ContentView: View {
    @State private var billAmount = ""
    @State private var selectedTipPercentage = 20
    @State private var isRoundingUp = false
    @State private var calculatedTipAmount: Double? = nil  // 儲存計算結果
    
    let tipPercentages = [
        (label: "Great", percentage: 20),
        (label: "Not Bad", percentage: 18),
        (label: "OK", percentage: 15)
    ]
    
    var tipAmount: Double {
        let bill = Double(billAmount) ?? 0
        let tipValue = bill * Double(selectedTipPercentage) / 100
        return isRoundingUp ? tipValue.rounded() : tipValue
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Section(header:
                            Text("Cost of service")
                                .foregroundColor(.black)
                                .font(.custom("DynaPuff-Regular", size: 24)) // 使用自定義字體和大小
                        ) {
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                    .foregroundColor(.green)
                                
                                TextField("0", text: $billAmount)
                                    .keyboardType(.decimalPad)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.vertical, 5)
                        }
                        
                        Section(header: Text("How was the service？")
                            .foregroundColor(.black)
                            .font(.custom("DynaPuff-Regular", size: 24))) {
                            Picker("服務品質", selection: $selectedTipPercentage) {
                                ForEach(tipPercentages, id: \.percentage) { tip in
                                    Text("\(tip.label) (\(tip.percentage)%)")
                                        .tag(tip.percentage)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Toggle("Round up tip?", isOn: $isRoundingUp)
                        }
                        
                        Section {
                            Button(action: {
                                calculatedTipAmount = tipAmount // 按下按鈕時進行計算
                            }) {
                                Text("Calculate")
                                    .foregroundColor(.black)
                                    .font(.custom("DynaPuff-Regular", size: 20))
                                    .padding(.horizontal, 105)
                            }
                        }
                        
                        if let result = calculatedTipAmount {
                            Section(header: Text("Tip Amount")
                                .foregroundColor(.black)
                                .font(.custom("DynaPuff-Regular", size: 24))) {
                                HStack {
                                    Text("$")
                                        .foregroundColor(.black)
                                        .font(.custom("DynaPuff-Regular", size: 20))
                                    Text(String(format: "%.2f", result))
                                        .foregroundColor(.black)
                                        .font(.custom("DynaPuff-Regular", size: 20))
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden) // 隱藏 Form 的背景
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Tip Time")
                            .font(.custom("DynaPuff-Regular", size: 48)) // 自定義字體
                            .foregroundColor(.black)
                            .padding(.top, 45)
                    }
                }
                .background(
                    Image("ice")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .opacity(0.4)
                )
                VStack {
                    Spacer() // 推動底部圖片到螢幕底部
                    HStack{
                        Spacer()
                        Image("thanks")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 145) // 調整圖片的高度
                            .padding(.bottom, 0) // 與底部保持適當間距
                    }
                    
                }
            }
            
        }
    }
}


#Preview {
    ContentView()
}
