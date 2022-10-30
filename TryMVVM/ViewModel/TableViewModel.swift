import Foundation

final class TableViewModel {
    
    let fetchService = FetchService()
    
    enum Action {
        case viewIsReady
        case cellDidTap
    }
    enum State {
        case initial
        case loading
        case loaded([User])
        case error
    }
    
    var stateChanged: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }
    
    func changeState(_ action : Action) {
        
        switch action {
        case .viewIsReady:
            state = .loading
            fetchService.fetchUsers { [weak self] result in
                switch result {
                    
                case .success(let model):
                    self?.state = . loaded(model)
                case .failure(_):
                    self?.state = .error
                }
            }
        case .cellDidTap:
            print("cell tapped")
        }
    }
}
