//
//  ChallengeView.swift
//  SplitIt
//
//  Created by Bhanuteja on 24/05/20.
//  Copyright © 2020 annam. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {
    @State private var enteredText = ""
    @State private var numberOfPeople = ""
    @State private var selectedPercentage = 2
    @State private var grandTotal = 0.0

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0.0 + Double(2)
        let tipSelection = Double(tipPercentages[selectedPercentage])
        let orderAmount = Double(enteredText) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        DispatchQueue.main.async {
            self.grandTotal = orderAmount + tipValue
        }
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Enter total amount", text: $enteredText)
                        .keyboardType(.decimalPad)
                }

                Section{
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("", selection: $selectedPercentage){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("We Split challenge", displayMode: .automatic)
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
