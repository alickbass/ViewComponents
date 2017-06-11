//
//  TestComponentPerformance.swift
//  ViewComponents
//
//  Created by Oleksii on 11/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

final class DetailsItemView: UIView {
    var title: UILabel!
    var value: UILabel!
}

final class DetailsCell: UITableViewCell {
    var title: UILabel!
    var container: UIView!
    var totalTitle: UILabel!
    var price: UILabel!
    
    var enterDate: DetailsItemView!
    var enterTime: DetailsItemView!
    var exitDate: DetailsItemView!
    var exitTime: DetailsItemView!
}

struct DetailsItem: ComponentConvertible {
    var toComponent: Component<DetailsItemView> {
        return Component<DetailsItemView>()
            .child({ $0.title }, Component().label(.text("title"), .font(.systemFont(ofSize: 12)), .textColor(#colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1))))
            .child({ $0.value }, Component().label(.text("value"), .font(.systemFont(ofSize: 14)), .textColor(#colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1))))
    }
}

struct DetailsCellViewModel: ComponentConvertible {
    var toComponent: Component<DetailsCell> {
        return Component()
            .child({ $0.container }, Component<UIView>().view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1))))
            .child({ $0.title },
                   Component<UILabel>()
                    .label(.text("Title"), .textColor(.white), .font(.systemFont(ofSize: 16)))
            )
            .child({ $0.totalTitle },
                   Component<UILabel>()
                    .label(.text("Total"), .textColor(.gray), .font(.systemFont(ofSize: 16)))
            )
            .child({ $0.price },
                   Component<UILabel>()
                    .label(.text("A lot of money"), .textColor(.green), .font(.boldSystemFont(ofSize: 16)))
            )
            .child({ $0.enterDate }, DetailsItem())
            .child({ $0.enterTime }, DetailsItem())
            .child({ $0.exitDate }, DetailsItem())
            .child({ $0.exitTime }, DetailsItem())
    }
}

class TestComponentPerformance: XCTestCase {
    
    func testPerformanceExample() {
        let viewModels = (0...10000).map({ _ in DetailsCellViewModel() })
        self.measure {
            _ = viewModels.map({ $0.toComponent })
        }
    }
    
}
