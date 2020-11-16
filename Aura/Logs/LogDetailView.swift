//
//  AddLogView.swift
//  Aura
//
//  Created by Stevhen on 15/10/20.
//

import SwiftUI

enum LogModal: String {
    case add = "Tambah Catatan"
    case detail = "Detail Catatan"
    case edit = "Edit Catatan"
    
    func printState() -> String {
        return self.rawValue
    }
}

struct LogDetailView: View {
    
    @Binding var showingModal: Bool
    @State var editDetailModal: Bool = false
    @State var showingMoodModal: Bool = false
    @State var showingHelpStatusModal: Bool = false
    @State var showingTriggerModal: Bool = false
    
    var modalState: LogModal
    
    //Fields
    @State var seizureLocation: String = ""
    @State var selectedHelpStatusIndex = 0
    @State var selectedMoodIndex = 0
    
    @State var note: String = ""
    
    var body: some View {
        
        //MARK: - Sheet Modal Header
        HStack {
            Button(action: {
                self.showingModal = false
            }, label: {
                Text("Cancel")
            })
            
            Spacer()
            
            Text(modalState.printState())
                .foregroundColor(.black)
                .bold()
            
            Spacer()
            
            Button(action: {
                //add data
                
                self.showingModal = false
            }, label: {
                if modalState == .add {
                    Text("Tambah")
                        .bold()
                }
                else if modalState == .detail {
                    Button(action: {
                        self.editDetailModal.toggle()
                    }, label: {
                        Text("Edit ")
                    })
                    .sheet(isPresented: $editDetailModal) {
                        LogDetailView(showingModal: self.$editDetailModal, modalState: .edit)
                    }
                }
                else if modalState == .edit {
                    Text("Selesai")
                        .bold()
                }
                //.foregroundColor(.gray) //selection here
            })
        }
        .foregroundColor(.blue)
        .padding(.top)
        .padding(.horizontal, 9)
        
        //MARK: - Log Detail Form
        Form {
            
//            CellSpacer()
            
            ///MARK: - Log Detail Top Section
            
            Section {
                TextField("Lokasi", text: $seizureLocation)
                    .foregroundColor(seizureLocation.isEmpty ? .gray : AuraColors.dimBlack)
                    .disabled(modalState == .detail)
                
                LogRowView(title: "Waktu dan Tanggal", status: "3 Okt 2020 09.00 AM", isNav: false)
                
                LogRowView(title: "Durasi", status: "1 Menit 30 Detik", isNav: false)
                
                Button(action: {
                    self.showingHelpStatusModal.toggle()
                }, label: {
                    LogRowView(title: "Status Pertolongan", status: helpStatuses[selectedHelpStatusIndex])
                })
                .sheet(isPresented: $showingHelpStatusModal) {
                    //help status view
                    HelpStatusView(selectedHelpStatusIndex: $selectedHelpStatusIndex)
                }
            }
            
//            CellSpacer()
            
            ///MARK: - Log Detail Bottom Section
            Section {
                
                Button(action: {
                    self.showingMoodModal.toggle()
                }, label: {
                    LogRowView(title: "Mood", status: moods[selectedMoodIndex])
                })
                .sheet(isPresented: $showingMoodModal) {
                    MoodView(selectedMoodIndex: $selectedMoodIndex)
                }
                
                Button(action: {
                    self.showingTriggerModal.toggle()
                }, label: {
                    LogRowView(title: "Pemicu")
                })
                .sheet(isPresented: $showingTriggerModal) {
                    //Trigger view
                    
                }
                
                ZStack {
                    TextEditor(text: $note)
                        .foregroundColor(note.isEmpty ? .gray : AuraColors.dimBlack)
                        .frame(height: 144, alignment: .topLeading)
                        .disabled(modalState == .detail)
//                    Text(note).opacity(0).padding(.all, 8)
                }
            }
            
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = UIColor.grayBg
        }
        
    }
}

var moods = ["Tidak Ada", "Senang", "Sedih", "Netral", "Takut", "Marah"]

struct MoodView: View {
    
    @Binding var selectedMoodIndex: Int
    
    var body: some View {
        Form {
            Section {
                ForEach(0 ..< moods.count) { i in
                    Button {
                        selectedMoodIndex = i
                    } label: {
                        PickerRowView(title: moods[i], isChecked: selectedMoodIndex == i)
                    }
                }
            }
        }
    }
}

var helpStatuses = ["Tidak Ada", "Tertolong", "Tidak Tertolong"]

struct HelpStatusView: View {
    
    @Binding var selectedHelpStatusIndex: Int
    
    var body: some View {
        Form {
            Section {
                ForEach(0 ..< helpStatuses.count) { i in
                    Button {
                        selectedHelpStatusIndex = i
                    } label: {
                        PickerRowView(title: helpStatuses[i], isChecked: selectedHelpStatusIndex == i)
                    }
                }
            }
        }
    }
}
