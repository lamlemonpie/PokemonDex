//
//  PokemonSmallView.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/17/22.
//

import SwiftUI
import Kingfisher

struct PokemonSmallView: View {
    let pokemon: Pokemon
    var isActive = true
    @State var isClicked = false

    @EnvironmentObject var pokemonViewModel: PokemonViewModel

    let circle: some View = Circle()
        .fill(Color("PokemonCell"))

    var body: some View {
        VStack {
            KFImage(URL(string: pokemon.sprites.frontDefault))
                .placeholder { ProgressView() }
                .downsampling(size: CGSize(width: 64.0, height: 64.0))
                .aspectRatio(contentMode: .fill)
                .background(circle)

            Text(pokemon.name.capitalized)
                .fontWeight(.semibold)

            Text(String(format: "#%03d", pokemon.id))

            NavigationLink(
                destination: PokemonInfoView(pokemon: pokemon),
                isActive: $isClicked) {
                EmptyView()
            }
            .opacity(0)
        }
        .onTapGesture {
            if isActive {
                isClicked = true
                pokemonViewModel.getPokemonDescription(pokemonID: pokemon.id)
            }
        }
    }
}

struct PokemonSmallView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSmallView(pokemon: Constants.pokemonDummy)
    }
}
