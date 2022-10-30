import UIKit
import RealmSwift
import RxSwift

class ViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var firstLabel : UILabel!
    @IBOutlet weak var secondLabel : UILabel!
    @IBOutlet weak var thirdLabel : UILabel!
    @IBOutlet weak var fourLabel : UILabel!
    @IBOutlet weak var SaveButton : UIButton!
    @IBOutlet weak var LoadButton : UIButton!
    
    // MARK: Parameter
    
   
    
    let viewModel = ViewModel()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupRealm()
        viewModel.setupRX()
        viewModel.setupPublish()
        viewModel.setupBehavior()
    }
    
    // MARK: Methods
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let adress = Adress()
        adress.street = "Moscow street"
        adress.house = 1
        
        let student = Student()
        student.name = "Ilya"
        student.adress = adress
        
        let first = Mark()
        first.course = "0696065"
        first.mark = 4
        
        let teacher = Teacher()
        teacher.name = "Ivan Sergeevich"
        first.teacher = teacher
        
        let second = Mark()
        second.course = "2222222"
        second.mark = 8
        
        let array = [first, second]
        student.marks.append(objectsIn: array)
        
        do {
            try viewModel.realm.write({
                viewModel.realm.add(student)
            })
        } catch let error {
            print(error)
        }
    }
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        let studentObject = viewModel.realm.objects(Student.self).map({$0})
        let AdressObject = viewModel.realm.objects(Adress.self).map({$0})
        
        for student in studentObject {
            print(student.name)
            firstLabel.text = student.name
        }
        for adress in AdressObject  {
            secondLabel.text = adress.street
        }
        let secondVC = TableViewController(viewModel: TableViewModel())
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

    // MARK: Private methods
   private  extension ViewController {
   
}

