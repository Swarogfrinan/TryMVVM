import Foundation

final class FetchService {
    let users = [
        User("Ivan", 25),
        User("Matvey", 65),
        User("Fedor", 54),
        User("LI Chan", 35),
        User("Jony Boy",25),
        User("Angela", 5),
        User("Hey", 115)
    ]
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        DispatchQueue.global().async {
            sleep(3)
            completion(.success(self.users))
        }
    }
}
