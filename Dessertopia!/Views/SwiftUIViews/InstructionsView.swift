//
//  InstructionsView.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.
//

import SwiftUI

struct InstructionsView: View {
    @EnvironmentObject private var detailViewModel: DetailsViewModel
    
    var body: some View {
        LazyVStack {
            ForEach(detailViewModel.dessert, id: \.self) { meal in
                
                Text(meal.strInstructions ?? InstructionConstant.defaultString )
                    .foregroundColor(.black)
                    .lineLimit(detailViewModel.isButtonTapped ? nil : 3)
                    .fixedSize(horizontal: false, vertical: detailViewModel.isButtonTapped)
                    .onTapGesture(count: 2) {
                        detailViewModel.isButtonTapped.toggle()
                    }
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    detailViewModel.isButtonTapped.toggle()
                }) {
                    Image(systemName: detailViewModel.isButtonTapped ? InstructionConstant.buttonUp : InstructionConstant.buttonDown)
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .offset(x: 10, y: 25)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundColor(.gray.opacity(0.4))
            )
            .padding(.horizontal, 12)
            .padding(.top, 30)
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
