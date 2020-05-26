//
//  UnitConersion.swift
//  100DaysOfSwiftUI
//
//  Created by Bhanuteja on 26/05/20.
//  Copyright © 2020 annam. All rights reserved.
//

import SwiftUI

struct UnitConersionView: View {
    let convertFromArr = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @State private var inputNumber = ""
        
    var outPutStr: String{
        let heightFeet = Measurement(value: Double(inputNumber) ?? 0,
                                     unit: getTempUnit(units: convertFromArr[inputUnit]))
        let displayStr = heightFeet.converted(to: getTempUnit(units: convertFromArr[outputUnit]))
        return "\(displayStr)"
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Convert from")){
                    Picker("", selection: $inputUnit){
                        ForEach(0 ..< convertFromArr.count) {
                            Text("\(self.convertFromArr[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Input string", text: $inputNumber)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Convert to")){
                    Picker("", selection: $outputUnit){
                        ForEach(0 ..< convertFromArr.count) {
                            Text("\(self.convertFromArr[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if inputNumber != ""{
                    Section{
                        Text("\(inputNumber) \(convertFromArr[inputUnit]) = \(outPutStr)")
                    }
                }
            }
            .navigationBarTitle("Unit Conversions", displayMode: .automatic)
        }
    }
    
    func getTempUnit(units: String) -> UnitTemperature{
        switch units {
        case "Celsius":
            return UnitTemperature.celsius
        case "Fahrenheit":
            return UnitTemperature.fahrenheit
        case "Kelvin":
            return UnitTemperature.kelvin
        default:
            return UnitTemperature.celsius
        }
    }
}

struct UnitConersion_Previews: PreviewProvider {
    static var previews: some View {
        UnitConersionView()
    }
}
