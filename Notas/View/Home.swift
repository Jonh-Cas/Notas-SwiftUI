//
//  Home.swift
//  Notas
//
//  Created by Jonathan Casillas on 03/08/23.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    //@FetchRequest(entity: Notas.entity(), sortDescriptors: [ NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var result : FetchedResults<Notas>

    //Predicates values
    // with predicates  predicate: NSPredicate(format: "fecha >= %@ " Date() as CVarArg ),
    // with predicates  predicate: NSPredicate(format: "nota == 'IMPORTANTE'"),
    // with predicates  predicate: NSPredicate(format: "nota BEGINSWITH 'IMPORTANTE' ),
    // with predicates  predicate: NSPredicate(format: "nota CONTAINS[c] 'IMPORTANTE' ),

    
    @FetchRequest(
        entity: Notas.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "fecha >= %@", Date() as CVarArg ),
        animation: .spring()
    ) var result : FetchedResults<Notas>
    
    var body: some View {
        NavigationView{
            List{
                ForEach( result ){
                    item in
                    VStack(alignment: .leading) {
                        Text(item.nota  ?? "")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date )
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }){
                            Label(title:  {
                                Text("Editar")
                            }, icon: {
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action: {
                            model.deleteData(item: item, contexto: context)
                        }){
                            Label(title:  {
                                Text("Eliminar")
                            }, icon: {
                                Image(systemName: "trash")
                            })
                        }
                    }))
                }
            }.navigationBarTitle("Notas") 
                .navigationBarItems(trailing: Button(action: {
                    model.show.toggle()
                        
                }){
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }).sheet(isPresented: $model.show, content: {
                    AddView(model: model)
                })
        }
    }
}
