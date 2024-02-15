//
//  ContentView.swift
//  RBTest
//
//  Created by Георгий Чебаков on 2/14/24.
//

import SwiftUI

struct ContentView: View {
    let coeff = [2.21, 3.41, 1.54]
    let stackes = [13, 16, 9]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            BookmakerViewOne(maxCoefficient: maxCoefficient(coeff: coeff),
                          coefficents: coeff)
            
            BookmakerViewTwo(stackes: stackes,
                             sum: stackes.reduce(0, { $0 + $1 }))
        }
        .frame(alignment: .leading)
        .padding(16)
    }
    
    private func maxCoefficient(coeff: [Double]) -> Int {
        Int(coeff.max() != nil ? coeff.max()! + 1 : 0)
    }
}

#Preview {
    ContentView()
}

struct BookmakerViewOne: View {
    let maxCoefficient: Int
    let coefficents: [Double]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Средние коэффициенты")
                .fontWeight(.semibold)
        
            VStack(spacing: 8) {
                HStack {
                    schedule(maxCoeff: maxCoefficient, 
                             coeff: coefficents[0],
                             color: .green)
                    Text("Выигрыш")
                        .opacity(0.3)
                    Spacer()
                    Text("\(coefficents[0].description)")
                        .fontWeight(.semibold)
                }
                .frame(alignment: .leading)
                HStack {
                    schedule(maxCoeff: maxCoefficient, 
                             coeff: coefficents[1],
                             color: .red)
                    Text("Проигрыш")
                        .opacity(0.3)
                    Spacer()
                    Text("\(coefficents[1].description)")
                        .fontWeight(.semibold)
                }
                .frame(alignment: .leading)
                HStack {
                    schedule(maxCoeff: maxCoefficient, 
                             coeff: coefficents[2],
                             color: .gray)
                    Text("Возврат")
                        .opacity(0.3)
                    Spacer()
                    Text("\(coefficents[2].description)")
                        .fontWeight(.semibold)
                }
                .frame(alignment: .leading)
            }
        }
    }
    
    @ViewBuilder
    private func schedule(maxCoeff: Int, 
                          coeff: Double,
                          color: Color) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundStyle(.gray.opacity(0.3))
            
            Rectangle()
                .foregroundStyle(color)
                .frame(width: (coeff/Double(maxCoeff))*220)
        }.frame(width: 220, height: 8)
    }
}

struct BookmakerViewTwo: View {
    let stackes: [Int]
    let sum: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Выигрыши/проигрыши по букмекерам")
                .fontWeight(.semibold)
        
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Image(.betboom)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 40)
                    
                    Text("\(sum) ставки")
                        .fontWeight(.semibold)
                }
                
                percents(stackes: stackes)
            }
        }
    }
    
    @ViewBuilder
    private func percents(stackes: [Int]) -> some View {
        HStack(spacing: 8) {
            ForEach(stackes, id: \.self) { stacke in
                VStack(alignment: stackes.last == stacke ?
                        .trailing : .leading,
                       spacing: 4) {
                    Rectangle()
                        .foregroundStyle(stackes.firstIndex(of: stacke) == 0 ?
                            .green : stackes.firstIndex(of: stacke) == 1 ?
                            .red : .gray)
                        .frame(width: Double(stacke)/Double(sum) * 350, height: 8)
                    
                    Text("\(stacke) (\(Int(Double(stacke)/Double(sum) * 100))%)")
                }
                
            }
        }
        .frame(width: 375, alignment: .leading)
    }
}
