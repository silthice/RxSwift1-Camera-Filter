import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["a","b"])

relay.asObservable()
    .subscribe({
        print($0)
    })

//relay.value = "asd"
relay.accept(["bbb", "333"])
relay.accept(relay.value + ["hahahaha"])
