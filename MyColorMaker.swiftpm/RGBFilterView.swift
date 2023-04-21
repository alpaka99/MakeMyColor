//
//  RGBFilterView.swift
//  MyColorMaker
//
//  Created by user on 2023/04/20.
//

import SwiftUI

struct RGBFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Colors.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Colors.date, ascending: true)]) var colors: FetchedResults<Colors>
    
    @State private var toAddColorView = false
    @State private var showDeleteAlert = false
    @State private var deleteId: UUID?
    @State private var detailColor: Colors?
    @State private var showSheet = false
    
    var redish: [Colors] {
        return colors.filter { $0.filter == "r"}
    }
    
    var greenish: [Colors] {
        return colors.filter { $0.filter == "g"}
    }
    
    var blueish: [Colors] {
        return colors.filter { $0.filter == "b"}
    }
    
    let scale = 2.0
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("", isActive: $toAddColorView) {
                    MakeColorView()
                }
                
                // for red-ish colors
                if redish.isEmpty == false {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(redish) { color in
                                GeometryReader { geo in
                                        Colorchip(image: color.image, name: color.name, date: color.date, color:  Color(color.color), scale: 2)
                                            .font(.largeTitle)
                                            .padding()
                                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                                            .frame(width: 200, height: 200)
                                        .onTapGesture {
                                            detailColor = color
                                            showSheet = true
                                        }
                                        .contextMenu {
                                            Button("Delete") {
                                                deleteId = color.id
                                                showDeleteAlert = true
                                            }
                                        }
                                }
                                .frame(width: 200, height: 250)
                            }
                        }
                    }
                }
                
                // for green-ish colors
                if greenish.isEmpty == false {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(greenish) { color in
                                GeometryReader { geo in
                                    Colorchip(image: color.image, name: color.name, date: color.date, color:  Color(color.color), scale: scale)
                                        .font(.largeTitle)
                                        .padding()
                                        .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                                        .frame(width: 200, height: 200)
                                        .onTapGesture {
                                            detailColor = color
                                            showSheet = true
                                        }
                                        .contextMenu {
                                            Button("Delete") {
                                                deleteId = color.id
                                                showDeleteAlert = true
                                            }
                                        }
                                }
                                .frame(width: 200, height: 250)
                            }
                        }
                    }
                }
                
                // for blue-ish colors
                if blueish.isEmpty == false {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(blueish) { color in
                                GeometryReader { geo in
                                    Colorchip(image: color.image, name: color.name, date: color.date, color:  Color(color.color), scale: scale)
                                        .font(.largeTitle)
                                        .padding()
                                        .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                                        .frame(width: 200, height: 200)
                                        .onTapGesture {
                                            detailColor = color
                                            showSheet = true
                                        }
                                        .contextMenu {
                                            Button("Delete") {
                                                deleteId = color.id
                                                showDeleteAlert = true
                                            }
                                        }
                                }
                                .frame(width: 200, height: 250)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
            .toolbar {
                ToolbarItem {
                    Button("Add a Color") {
                        toAddColorView = true
                    }
                }
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("Do you really want to delete this memory?"),
                    primaryButton: .destructive(Text("Delete")) {
                        dismiss()
                        deleteColor(id: deleteId!)
                    }, secondaryButton: .default(Text("Cancel")) {
                        deleteId = nil
                    })
            }
            .sheet(item: $detailColor) {color in
                DetailColorView(color: color)
                Button("Got it") {
                    detailColor = nil
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
        
    func deleteColor(id: UUID) {
        let deletingId  = id
        
        for i in 0..<colors.count {
            if deletingId == colors[i].id {
                viewContext.delete(colors[i])
                break
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError.localizedDescription)")
        }
    }
}

struct RGBFilterView_Previews: PreviewProvider {
    static var previews: some View {
        RGBFilterView()
    }
}
