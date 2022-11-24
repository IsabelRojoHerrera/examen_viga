//
//  ContentView.swift
//  viga
//
//  Created by Isabel Rojo on 23/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State var clv_obra = ""
    @State var clv_viga = ""
    @State var longitud = ""
    @State var material = ""
    @State var peso = ""
    @State var seleccionado:Viga?
    @State var vigaArray = [Viga]()
    
    var body: some View{
        VStack{
            TextField("Clave de obra", text: $clv_obra)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Clave de viga", text: $clv_viga)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Longitud de viga", text: $longitud)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Tipo de material", text: $material)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Peso de la viga", text: $peso)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("SAVE"){
                
                if (seleccionado != nil){
                    seleccionado?.clv_obra = clv_obra
                    seleccionado?.clv_viga = clv_viga
                    seleccionado?.longitud = longitud
                    seleccionado?.material = material
                    seleccionado?.peso = peso
                    coreDM.actualizarViga(viga: seleccionado!)
                }else{
                    coreDM.guardarViga(clv_obra: clv_obra, clv_viga: clv_viga, longitud: longitud, material: material, peso: peso)
                }
                mostrarVigas()
                clv_obra = ""
                clv_viga = ""
                longitud = ""
                material = ""
                peso = ""
                seleccionado = nil
            }
            List{
                ForEach(vigaArray, id: \.self){
                vig in
                VStack{
                    Text(vig.clv_obra ?? "")
                    Text(vig.clv_viga ?? "")
                    Text(vig.longitud ?? "")
                    Text(vig.material ?? "")
                    Text(vig.peso ?? "")
                }
                .onTapGesture {
                    seleccionado = vig
                    clv_viga = vig.clv_viga ?? ""
                    clv_obra = vig.clv_obra ?? ""
                    longitud = vig.longitud ?? ""
                    material = vig.material ?? ""
                    peso = vig.peso ?? ""
                }
            }
            .onDelete(perform: {
                indexSet in
                indexSet.forEach({index in
                    let viga = vigaArray[index]
                    coreDM.borraViga(viga: viga)
                    mostrarVigas()
                })
            })
        }
        Spacer()
    }.padding()
        .onAppear(perform: {
            mostrarVigas()
        })
        
    }

    func mostrarVigas(){
        vigaArray = coreDM.leerVigas()
    }
}


struct ContentView_preViews: PreviewProvider{
    static var previews: some View{
        ContentView(coreDM: CoreDataManager())
    }
}



    
