//
//  ViewModel.swift
//  Notas
//
//  Created by Jonathan Casillas on 03/08/23.
//

import Foundation
import CoreData
import SwiftUI


class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    //CoreData
    
    func saveData(context: NSManagedObjectContext ){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try context.save()
            print("guardo")
            show.toggle()
        } catch let error as NSError {
            // alerta al usuario
            
            print("No guardo --> ", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, contexto: NSManagedObjectContext ){
        contexto.delete(item)
        //try! contexto.save()
        
        do {
            try contexto.save()
            print("Elimino correctamente")
        } catch let error as NSError {
            print("Ocurrio un Error al Eliminar --> ", error.localizedDescription )
        }
    }
    
    func sendData ( item: Notas ){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editData ( context: NSManagedObjectContext ) {
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("se Edito")
        } catch let error as NSError {
            print("Ocurrio un error al editar -> ", error.localizedDescription)
        }
    }
    
}
