import SwiftUI
import Challenges

struct ContentView: View {
    @State var name = FormField<String>(title: "Name", value: "", validations: [.required, .minValue(2)])
    @State var email = FormField<String>(title: "Email", value: "", validations: [.required, .email])

    @FocusState var nameFocused: Bool
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(name.title, text: $name.value)
                    TextField(email.title, text: $email.value)
                }

                Section {
                    Button("Submit", action: submit)
                }
            }
            .navigationBarTitle("TrackVia iOS Challenge")
        }
    }
    
    private func submit() {
        do {
            try name.update(name.value)
            try name.update(email.value)
        } catch {
            print("Error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
