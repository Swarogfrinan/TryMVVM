import RealmSwift
import Foundation

class Student : Object {
    @Persisted var name = ""
    @Persisted var adress : Adress?
    @Persisted var teacher : Teacher?
    let marks = List<Mark>()
    func setValue(realmsStudents : StudentModel) {
        self.name = realmsStudents.name
    }
}
class Adress : Object {
    @Persisted var street = ""
    @Persisted var house = 0
}

class Mark : Object {
    @Persisted var course = ""
    @Persisted var mark = 0
    @Persisted var teacher : Teacher?
}

class Teacher : Object {
    @Persisted var name = ""
}

