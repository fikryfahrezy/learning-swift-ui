//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 18/01/24.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1, label: {
                        Text("Length")
                    })
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
                ThemePicker(selection: $scrum.theme)
            } header: {
                Text("Meeting Info")
            }
            Section {
                ForEach(scrum.attendees) { attende in
                    Text(attende.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Spacer()
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
                
            } header: {
                Text("Attendees")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailEditView(scrum: .constant(DailyScrum.emptyScrum))
    }
}
