import Foundation

typealias HistoryItem = (numb1: Int, numb2: Int, numb3: Int, numb4: Int, exactly: Int, exist: Int)

class BurglarEngine {
    
    private let countOfnumbers: Int = 4
    private var exactly = 0
    private var exist = 0
    
    var numbersForUnlock = [Int]()
    var history = [HistoryItem]()
    
    init() {
        setupNumber()
    }
    
    func setupNumber() {
        exist = 0
        exactly = 0
        history.removeAll()
        numbersForUnlock.removeAll()
        
        for _ in 1...countOfnumbers {
            numbersForUnlock.append(Int(arc4random_uniform(10)))
        }
    }
    
    func checkNumber(numbers: [Int]) -> Bool {
        guard numbers.count == countOfnumbers else { fatalError() }
        exactlyCheck(numbers: numbers)
        existCheck(numbers: numbers)
        let historyItem: HistoryItem = (numb1:numbers[0], numb2:numbers[1], numb3:numbers[2], numb4:numbers[3], exactly: exactly, exist: exist)
        self.history.append(historyItem)
        
        return historyItem.exactly == self.countOfnumbers
    }
    
    private func exactlyCheck(numbers: [Int]) {
        for i in 0...countOfnumbers - 1 {
            if numbers[i] == numbersForUnlock[i] {
                self.exactly += 1
            }
        }
    }
    
    private func existCheck(numbers: [Int]) {
        for number in numbers {
            for unlockNumber in numbersForUnlock {
                if number == unlockNumber {
                    exist += 1
                }
            }
        }
        exist -= exactly
    }
    
}

