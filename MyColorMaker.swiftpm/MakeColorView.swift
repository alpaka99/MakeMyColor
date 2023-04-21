//
//  LabelColorView.swift
//  MyColorMaker
//
//  Created by user on 2023/04/20.
//

import SwiftUI
import CoreData

struct MakeColorView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Colors.entity(), sortDescriptors: []) private var memories: FetchedResults<Colors>
    
    @State private var image: Image?
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var averageUIColor: UIColor?
    @State private var text = ""
    @State private var pickedColor: Color = Color.white
    @State private var date: Date = Date()
    
    let id = UUID()
    
    var body: some View {
        Form {
            Section("Choose Color") {
                VStack(alignment: .center) {
                    if image != nil {
                        image!
                            .resizable()
                            .scaledToFit()
                        
                        Button("Change image") {
                            showImagePicker = true
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.secondary)
                            
                            Text("Tap if you want to extract color from a picture!📷")
                                .tint(.white)
                        }
                        .onTapGesture {
                            showImagePicker = true
                        }
                    }
                }
                .frame(width: 200, height: 200)
                

                    
                    // dominat color & color picker
                    Rectangle()
                        .fill((averageUIColor != nil) ? Color(averageUIColor!) : .clear)
                        .frame(width: 200, height: 200)
                        .overlay {
                            ColorPicker("Choose your own color🖍️", selection: $pickedColor)
                                .onChange(of: pickedColor) { _ in
                                    averageUIColor = UIColor(pickedColor)
                                }
                                .background(.white)
                        }
                }
            
            Section("Label it") {
                TextField("Make a name for this beautiful color!🎨",text: $text)
            }
            
            Section("Special info?") {
                DatePicker("Any special date for this color?", selection: $date, displayedComponents: [.date])
            }
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            ToolbarItem {
                Button("Collect this color!") {
                    addNewColor()
                    dismiss()
                }
                .disabled(averageUIColor == nil || text == "")
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        setAverageColor()
        
    }
    
    func setAverageColor() {
        if let averageColor = inputImage?.averageColor {
            averageUIColor = averageColor
        }
    }
    
    func addNewColor() {
        let newColor = Colors(context: viewContext)
        newColor.name = text
        newColor.id = id
//        newColor.image = ((inputImage != nil) ?  inputImage?.pngData() : UIImage(named: "sample_image")?.pngData())!
//        newColor.image = ((inputImage != nil) ?  inputImage?.pngData() : nil
        newColor.image = inputImage?.pngData()

        newColor.color = averageUIColor!
        newColor.date = date
        newColor.hexcode = averageUIColor?.toHexString() ?? "ffffff"
        newColor.filter = averageUIColor?.filteredColor() ?? "r"
        
        var test = newColor.color.getRGBA()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError.localizedDescription)")
        }
        
        
    }
    
}










struct MakeColorView_Previews: PreviewProvider {
    static var previews: some View {
        MakeColorView()
    }
}
