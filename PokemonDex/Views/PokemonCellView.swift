//
//  PokemonCellView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/12/22.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemon: String

    let rectangle: some View = RoundedRectangle(cornerRadius: 16)
        .fill(Color("PokemonCell"))
        .padding(.leading, 24.0)
        .frame(maxWidth: .infinity, maxHeight: 80.0)

    var body: some View {
        HStack {
            Text("Image").frame(width: 72.0, height: 72.0)

            Spacer()

            VStack(alignment: .leading) {
                Text("\(pokemon)")
                    .fontWeight(.semibold)

                Text("#001")
            }

            Spacer()

            HStack {
                Text("X").frame(width: 30.0, height: 30.0)
                Text("Y").frame(width: 30.0, height: 30.0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 80.0)
        .background(rectangle)
        .cornerRadius(16)
    }
}

struct PokemonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCellView(pokemon: "Bulbasaur")
    }
}
