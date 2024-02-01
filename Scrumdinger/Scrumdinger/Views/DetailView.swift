//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 18/01/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var editingScrum: DailyScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    MeetingView(scrum: $scrum)
                } label: {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                }
                
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .clipShape(.buttonBorder)
                }
                .accessibilityElement(children: .combine)
            } header: {
                Text("Meeting Info")
            }
            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }
            Section {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                
                ForEach(scrum.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
                
            } header: {
                Text("History")
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button {
                editingScrum = scrum
                isPresentingEditView = true
            } label: {
                Text("Edit")
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                editingScrum = scrum
                                isPresentingEditView = false
                            } label: {
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                scrum = editingScrum
                                isPresentingEditView = false
                            } label: {
                                Text("Done")
                            }
                        }
                    }
            }
        }
    }
}


// A View that simply wraps the real view we're working on
// Its only purpose is to hold state
struct DetailViewContainer: View {
    @State private var scrum = DailyScrum.sampleData[0]
    
    var body: some View {
        DetailView(scrum: $scrum)
    }
}


#Preview {
    NavigationStack {
        DetailViewContainer()
    }
}
