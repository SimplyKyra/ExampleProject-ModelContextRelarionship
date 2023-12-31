////
////  MultiSelectPickerView.swift
////  multiselectionPickerSwiftData
////
////  Created by Kyra Delaney on 12/30/23.
////
//
//import SwiftUI
//
//
//// The struct that the custom picker (button) opens which
//// is minorly adapted from:
//// https://gist.github.com/dippnerd/5841898c2cf945994ba85871446329fa
//struct MultiSelectPickerView: View {
//    // The list of items we want to show
//    @State var allItems: [myItem]
//
//    // Binding to the selected items we want to track
//    @Binding var selectedItems: [myItem]
//
//    var body: some View {
//        Form {
//            List {
//                ForEach(allItems, id: \.self) { item in
//                    Button(action: {
//                        withAnimation {
//                            if self.selectedItems.contains(item) {
//                                // Previous comment: you may need to adapt this piece
//                                self.selectedItems.removeAll(where: { $0 == item })
//                            } else {
//                                self.selectedItems.append(item)
//                            }
//                        }
//                    }) {
//                        HStack {
//                            Image(systemName: "checkmark")
//                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
//                            Image(systemName: item.imageName)
//                        }
//                    }
//                    .foregroundColor(.primary)
//                }
//            }
//        }
//    }
//}
//#Preview {
//    MultiSelectPickerView()
//}
