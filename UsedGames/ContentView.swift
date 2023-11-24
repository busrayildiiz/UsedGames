//
//  ContentView.swift
//  UsedGames
//
//  Created by MacBook Pro on 10.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var gameStore = GameStore()
    var imageStore = ImageStore()

    @State var gameToDelete : Game?
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(gameStore.games) {(game) in
                    NavigationLink(destination: DetailView(game: game,
                                                           gameStore: gameStore,
                                                           imageStore: imageStore,
                                                           name: game.name,
                                                           price: game.priceInDollars
                                                        )
                    ){
                        GameListItem(game: game)
                    }
                }.onDelete { IndexSet in
                    self.gameToDelete = gameStore.game(at: IndexSet)
                }.onMove(perform: {indices, newOffset in
                    gameStore.move(indices: indices,
                                   to: newOffset)
                })
                
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Used Games")
            .navigationBarItems(leading:EditButton(),
                                 trailing:
                                    Button(action:{ gameStore.createGame()},
                                           label: {Text("Add")} ))
            .navigationBarTitleDisplayMode(.large)
            .padding(.top, 20)
                .animation(.easeIn)
                .actionSheet(
                    item: $gameToDelete){ (game)
                        -> ActionSheet in
                        
                        ActionSheet(title: Text("Are you sure?"),
                                    message: Text("You will delete '\(game.name)'."),
                                    buttons: [
                            .cancel(),
                            .destructive(Text("Delete"), action: {
                                if let indexSet = gameStore.indexSet(for: game) {
                                    gameStore.deleteItem(at: indexSet)
                                }
                            })]
                        )
                    }
                   
        }
      
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    



