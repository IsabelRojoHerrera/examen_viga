//
//  CoreDataManager.swift
//  examen_icrh
//
//  Created by Isabel Rojo on 23/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Viga")
        persistentContainer.loadPersistentStores(completionHandler:{
            (description, error) in
            if let error = error{
                fatalError("Core data failed\(error.localizedDescription)")
            }
            
        })
    }
    func guardarViga(clv_obra:String, clv_viga:String, longitud:String, material:String, peso:String ){
        let viga = Viga(context: persistentContainer.viewContext)
        viga.clv_obra = clv_obra
        viga.clv_viga = clv_viga
        viga.longitud = longitud
        viga.material = material
        viga.peso = peso
        
        do{
            try persistentContainer.viewContext.save()
            print("Viga guardada")
        }
        catch{
            print ("falla")
        }
    }
    
    func leerVigas() -> [Viga] {
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerViga(clv_viga:String) -> Viga?{
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "clave = %@", clv_viga)
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
            }
        catch{
            print("No se puede leer ese dato")
        }
        return nil
    }
    
    func actualizarViga(viga: Viga){
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "clave = %@", viga.clv_viga ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let v = datos.first
            v?.clv_obra = viga.clv_obra
            v?.longitud = viga.longitud
            v?.material = viga.material
            v?.peso = viga.peso
            try persistentContainer.viewContext.save()
            print("Viga actualizada")
        }catch{
            print("no se pudo actualizar")
        }
    }
    
    func borraViga(viga:Viga){
        persistentContainer.viewContext.delete(viga)
    }
}
