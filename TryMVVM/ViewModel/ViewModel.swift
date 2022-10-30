import Foundation
import RxRelay
import RxSwift
import RealmSwift

final class ViewModel {
    
    let publish = PublishRelay<String>()
    
    let behavior = BehaviorRelay<String>(value: "InitialBehavior")
    
    let disposeBag = DisposeBag()
     lazy  var realm: Realm = {
        let manager = try! Realm()
        return manager
    }()
    
    func setupRX() {
        let observable = Observable.just("Hello")
        _ = observable.subscribe({ event in
            print(event)
        }).disposed(by: disposeBag)
        let array = [1, 1, 2, 3, 4, 4, 5, 6, 7, 8, 8, 0, 3, 9, 23]
        let intSequense = Observable
            .from(array)
            .distinctUntilChanged()
        
        intSequense.subscribe({ event in
            print(event)
        })
    }
    
    func setupRealm() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        var configuration = Realm.Configuration()
        configuration.deleteRealmIfMigrationNeeded = true

        realm = try! Realm(configuration: configuration)
    }
    func setupPublish() {
        publish.subscribe({ event in
            print("First: \(event)")
        }).disposed(by: disposeBag)
        print("1 Subscribed")
        
        publish.accept("First song accept")
        publish.subscribe({ event in
            print("Second: \(event)")
        }).disposed(by: disposeBag)
        print("Second Subsribed")
        publish.accept("Second song accept")
        
        publish.subscribe({ event in
            print("Third: \(event)")
        }).disposed(by: disposeBag)
        print("Third subscribed")
        publish.accept("Third song accept")
    }
    
    func setupBehavior() {
        behavior.subscribe({ event in
            print("First : \(event)")
        }).disposed(by: disposeBag)
        print("Subscribe First Behavior")
        
        behavior.accept("First track - Scorpions")
        
        behavior.subscribe({ event in
            print("Second : \(event)")
        }).disposed(by: disposeBag)
        print("Subscribe Second Behavior")
        
        behavior.accept("Second track - ACDC")
        
        behavior.subscribe({ event in
            print("Third: \(event)")
        }).disposed(by: disposeBag)
        print("Third Subscribe Behavior")
        behavior.accept("DEeep purple")
    }
    
}
