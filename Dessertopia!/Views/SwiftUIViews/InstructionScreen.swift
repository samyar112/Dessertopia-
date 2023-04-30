//
//  InstructionView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//

import SwiftUI

struct InstructionScreen: View {
    @EnvironmentObject private var detailVM: DetailsViewModel
    var body: some View {
        NavigationView {
            ScrollView{
                ForEach(detailVM.dessert, id: \.self) { meal in
                    Text(meal.strInstructions ?? InstructionConstant.defaultString)
                        .font(.body)
                    
                        .padding(10)
                        .navigationBarHidden(false)
                        .navigationTitle(InstructionConstant.title)
                }
            }
        }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionScreen()
    }
}

