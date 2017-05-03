# ViewComponents
Declarative view components

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![Build Status](https://travis-ci.org/alickbass/ViewComponents.svg?branch=master)](https://travis-ci.org/alickbass/ViewComponents)
[![codecov](https://codecov.io/gh/alickbass/ViewComponents/branch/master/graph/badge.svg)](https://codecov.io/gh/alickbass/ViewComponents)

## How to use

Let's say we have a following custom view:

```swift
class MyCustomView: UIView {
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myButton: UIButton!
    @IBOutlet var myIcon: UIImageView!
}
```

With **ViewComponents** you can easily create immutable values that represent the styling of the view hierarchy like this:

```swift
let buttonComponent = Component<UIButton>().buttonStyles(
    .title("Test", for: .normal),
    .titleColor(.red, for: .normal)
)

let labelComponent = Component<UILabel>()
    .labelStyles(
        .text("MyLabel"),
        .font(.boldSystemFont(ofSize: 12))
    )
    .viewStyles(
        .backgroundColor(.blue)
    )

let viewComponent = Component<MyCustomView>()
    .child(buttonComponent, { $0.myButton })
    .child(labelComponent, { $0.myLabel })
```

and then when we need to apply our style we do the following:

```swift
viewComponent.configure(view: myCustomeView)
```
