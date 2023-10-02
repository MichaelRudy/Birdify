import SwiftUI

struct AddCourse: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var golfModel: GolfGameViewModel
    @State private var courseName: String = ""
    @State private var coursePar: String = ""
    @State private var holeCount: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Course Information").font(.title2).bold().italic().foregroundColor(.blue)) {
                    TextField("Course Name", text: $courseName)
                        .padding()
                    TextField("Course Par", text: $coursePar)
                        .keyboardType(.numberPad)
                        .padding()
                    TextField("Hole Count", text: $holeCount)
                        .keyboardType(.numberPad)
                        .padding()
                }
            }
            .navigationTitle("Add Course")
            .navigationBarItems(trailing: Button(action: {
                golfModel.validateCourse(name: self.courseName, par: self.coursePar, holeCount: self.holeCount)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Start Golf Round")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
        }
        .padding()
    }
}


struct AddCourse_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddCourse().environmentObject(GolfGameViewModel())
        }
    }
}
