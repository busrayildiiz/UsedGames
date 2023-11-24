//
//  DetailView.swift
//  UsedGames
//
//  Created by MacBook Pro on 4.03.2023.
//

import SwiftUI
import Combine

struct DetailView: View {
    
    var game: Game
    var gameStore: GameStore
    var imageStore : ImageStore

    @State var name : String = ""
    @State var price : Double = 0.0
    
    @State var shouldEnableSaveButton : Bool = true
    @State var isPhotoPickerPresenting : Bool = false
    @State var isPhotoPickerActionSheetPresenting : Bool = false
    @State var sourceType : UIImagePickerController.SourceType = .photoLibrary

    @State var selectedPhoto : UIImage?
    
    func validate(){
        
        shouldEnableSaveButton = game.name != name || game.priceInDollars != price
    }
    
    func createActionSheet() -> ActionSheet {
        var buttons: [ActionSheet.Button] = [
            .cancel()
        ]
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            buttons.append(
                .default(
                    Text("Camera"),
                    action: {
                        sourceType = .camera
                        isPhotoPickerPresenting = true
                    }
                )
            )
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            buttons.append(
                .default(
                    Text("Photo Library"),
                    action: {
                        sourceType = .photoLibrary
                        isPhotoPickerPresenting = true
                    }
                )
            )
        }
        return ActionSheet(title:
                            Text("Please select a source"),
                            message: nil,
                            buttons: buttons)
    }
    


        
    var body: some View {
        Form{
            Section{
                VStack(alignment: .leading, spacing: 4.0){
                    Text("Name")
                        .font(.body)
                        .foregroundColor(.secondary)
                    TextField("Name", text: $name )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onReceive(Just(name)) { newValue in
                            validate()
                            }
                }
                VStack(alignment: .leading, spacing: 4.0){
                    Text("Price in Dollars")
                        .font(.body)
                        .foregroundColor(.secondary)
                    TextField("Price", value: $price, formatter: Formatters.dollarFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onReceive(Just(price)) { newPrice in
                            validate()
                        }
                }
            }
            
            if let selectedPhoto = selectedPhoto {
                Section(header: Text("Image")){
                    Image(uiImage: selectedPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                    
                }
            }
            Section{
                Button (
                    action: {
                        let newGame = Game(name: name,
                                           priceInDollars: price,
                                           serialNumber: game.serialNumber)
                        gameStore.update(game: game,
                                         newValue: newGame)
                    },
                    label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30.0)
                    })
                
                .disabled(!shouldEnableSaveButton)
            }
        }
        
        .actionSheet(isPresented: $isPhotoPickerPresenting, content: {
            createActionSheet()
        })
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPhotoPickerPresenting, content: {
            PhotoPicker(sourceType: sourceType, selectedPhoto: $selectedPhoto)
            
        });
        TabView(){
            Button(action: {
                if
                    UIImagePickerController
                        .isSourceTypeAvailable(.camera) {
                    isPhotoPickerActionSheetPresenting = true
                }
                else {
                    isPhotoPickerPresenting = true
                }
                    
            }, label: {
                Image(systemName: "camera")
            })
            
        }.frame(height: 100)
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            
            let gameStore = GameStore()
            let game = gameStore.createGame()
        
            
            DetailView(game: game, gameStore: GameStore())
            
            
        }
    }
}
