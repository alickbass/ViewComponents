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
    var title = UILabel()
    var value = UILabel()
}

final class DetailsCell: UITableViewCell {
    var title = UILabel()
    var container = UIView()
    var totalTitle = UILabel()
    var price = UILabel()
    
    var enterDate = DetailsItemView()
    var enterTime = DetailsItemView()
    var exitDate = DetailsItemView()
    var exitTime = DetailsItemView()
}

struct DetailsItem: ComponentConvertible {
    var toComponent: Component<DetailsItemView> {
        return Component<DetailsItemView>().withChildren(
            .child({ $0.title },
                Component()
                    .view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2), .clipsToBounds(true), .isHidden(true))
                    .label(.text("title"), .font(.systemFont(ofSize: 12)), .textColor(#colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1)))
            ),
            .child({ $0.value },
                Component()
                    .view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2), .clipsToBounds(true), .isHidden(true))
                    .label(.text("value"), .font(.systemFont(ofSize: 14)), .textColor(#colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1)))
            )
        )
    }
}

struct DetailsCellViewModel: ComponentConvertible {
    var toComponent: Component<DetailsCell> {
        return Component()
            .view(
                .backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2),
                .clipsToBounds(true), .isHidden(true),
                .isMultipleTouchEnabled(true), .isOpaque(true)
            )
            .view(
                .backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2),
                .clipsToBounds(true), .isHidden(true),
                .isMultipleTouchEnabled(true), .isOpaque(true)
            )
            .view(
                .backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2),
                .clipsToBounds(true), .isHidden(true),
                .isMultipleTouchEnabled(true), .isOpaque(true)
            )
            .withChildren(
                .child({ $0.container }, Component<UIView>().view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)))),
                .child({ $0.title },
                    Component<UILabel>()
                    .view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2), .clipsToBounds(true), .isHidden(true))
                    .label(.text("Title"), .textColor(.white), .font(.systemFont(ofSize: 16)))
                ),
                .child({ $0.totalTitle },
                    Component<UILabel>()
                    .view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)), .alpha(0.2), .clipsToBounds(true), .isHidden(true))
                    .label(.text("Total"), .textColor(.gray), .font(.systemFont(ofSize: 16)))
                ),
                .child({ $0.price },
                    Component<UILabel>()
                    .view(.backgroundColor(#colorLiteral(red: 1, green: 0.8470588235, blue: 0, alpha: 1)))
                    .label(.text("A lot of money"), .textColor(.green), .font(.boldSystemFont(ofSize: 16)))
                ),
                .child({ $0.enterDate }, DetailsItem()),
                .child({ $0.enterTime }, DetailsItem()),
                .child({ $0.exitDate }, DetailsItem()),
                .child({ $0.exitTime }, DetailsItem())
            )
    }
}

class TestComponentPerformance: XCTestCase {
    
    let viewModels = (0...10000).map({ _ in DetailsCellViewModel() })
    
    func testToComponent() {
        self.measure {
            _ = self.viewModels.map({ $0.toComponent })
        }
    }
    
    func testDiffing() {
        let viewModels = self.viewModels.lazy.map({ $0.toComponent })
        let zipped = Array(zip(viewModels, viewModels))
        
        self.measure {
            _ = zipped.map({ $0.0.diffChanges(from: $0.1) })
        }
    }
    
    func testConfiguring() {
        let viewModels = self.viewModels.map({ $0.toComponent })
        let view = DetailsCell()
        
        self.measure {
            viewModels.forEach({ $0.configure(item: view) })
        }
    }
    
}
