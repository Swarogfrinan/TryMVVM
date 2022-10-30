import Foundation

struct StudentModel {
    let name : String
    let adress : AdressModel?
}

struct AdressModel {
    let street : String
    let house : Int
}
struct MarkModel {
    let course : String
    let mark : Int
    let teacher : TeacherModel?
}

struct TeacherModel {
    let name : String
}
