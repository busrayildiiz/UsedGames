//
//  GameListItem.swift
//  UsedGames
//
//  Created by MacBook Pro on 4.03.2023.
//

import SwiftUI

struct GameListItem: View {
    
    var game : Game
    var numberFormatter : NumberFormatter = Formatters.dollarFormatter
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3.0) {
                Text(game.name)
                    .font(.body)
                Text(game.serialNumber)
                    .font(.caption)
                    .foregroundColor(Color(white: 0.5))
                
            }
            Spacer()
            Text(NSNumber(value: game.priceInDollars), formatter: numberFormatter)
                .font(.body)
                .foregroundColor(game.priceInDollars > 30 ? .blue : .orange )
        }
        .padding(.vertical, 4)
    }
}

struct GameListItem_Previews : PreviewProvider {
    
    
    static var previews: some View {
        
        let item = GameListItem(game: Game(random: true))

        Group {
            item
                .padding(.horizontal)
                .previewLayout(.sizeThatFits)
            
            item
                .padding(.horizontal)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            item
                .padding(.horizontal)
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .accessibilityLarge)
         
       
        
    }
    }
}
