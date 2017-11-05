import Foundation

class Timer {
    
    static let instance = Timer()
    private var timerArray = [String:TimerData]()

    private class TimerData {
        var tickCount: Int
        let dispatch_timer:DispatchSourceTimer!
        let queue: DispatchQueue
        init(tickCount: Int, dispatch_timer: DispatchSourceTimer, queue: DispatchQueue) {
            self.tickCount = tickCount
            self.dispatch_timer = dispatch_timer
            self.queue = queue
        }
    }
    
    //MARK:- Main functions
    
    class func startCountdown(key: String,
                              tickCount: Int!,
                              tickAction: (()->())? = nil,
                              completion: @escaping (()->())) {
        let q = DispatchQueue(label:"timer.queue:\(key)")
        let dispatch_timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.init(rawValue: 0), queue:q)
        let timerData = TimerData(tickCount: tickCount, dispatch_timer: dispatch_timer, queue: q)
        Timer.instance.timerArray[key.uppercased()] = timerData
        
        q.async{
            let interval: Double = 1.0
            let delay = DispatchTime.now()
            dispatch_timer.schedule(deadline: delay, repeating: interval, leeway: .nanoseconds(0))
            dispatch_timer.setEventHandler {
                print(">>> TIMER:  tick...\(timerData.tickCount)")
                timerData.tickCount -= 1
                if timerData.tickCount <= 0 {
                    Timer.stopTimer(key: key)
                    completion()
                    
                }
            }
            dispatch_timer.resume()
        }
    }

    class func startTimer(key: String, tickAction: @escaping (()->())) {
        let q = DispatchQueue(label:"timer.queue:\(key)")
        let dispatch_timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.init(rawValue: 0), queue:q)
        let timerData = TimerData(tickCount: 0, dispatch_timer: dispatch_timer, queue: q)
        Timer.instance.timerArray[key.uppercased()] = timerData
        
        q.async{
            let interval: Double = 1.0
            let delay = DispatchTime.now()
            dispatch_timer.schedule(deadline: delay, repeating: interval, leeway: .nanoseconds(0))
            dispatch_timer.setEventHandler {
                tickAction()
            }
            dispatch_timer.resume()
        }
    }
    
    class func stopTimer(key: String) {
        let timerData = Timer.instance.timerArray[key.uppercased()]
        timerData?.dispatch_timer.cancel()
        Timer.instance.timerArray[key.uppercased()] = nil
    }
    
    //MARK:- Service
    
    class func tickCount(key: String) -> Int {
        guard let timerData = Timer.instance.timerArray[key] else {
            return 0
        }
        
        return timerData.tickCount
    }
    
    class func count() -> Int {
        return Timer.instance.timerArray.count
    }
}
