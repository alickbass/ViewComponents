# ViewComponents
Declarative view components

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![Build Status](https://travis-ci.org/alickbass/ViewComponents.svg?branch=master)](https://travis-ci.org/alickbass/ViewComponents)
[![codecov](https://codecov.io/gh/alickbass/ViewComponents/branch/master/graph/badge.svg)](https://codecov.io/gh/alickbass/ViewComponents)

## What is ViewComponents

ViewComponents is a library that helps you to create View Models that are:

* [**Declarative**](#why-declarative)
* [**Composable**](#why-composable)
* [**Efficient**](#why-efficient)
* [**Perfect fit to MVVM architecture**](#how-to-use-with-mvvm)
* [**Easy to test**](#why-easy-to-test)

## Why declarative?

You describe how the view should look like and the library will take care to applying the styling. Here's an example:

```swift
let buttonComponent = Component<UIButton>().button(
    .title("Test", for: .normal),
    .titleColor(.red, for: .normal)
)

let myButton: UIButton /// The button we want to style
buttonComponent.configure(view: myCustomeView)
```

No more manually setting the views properties! 

## Why composable?

```swift
class MyCustomView: UIView {
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myButton: UIButton!
    @IBOutlet var myIcon: UIImageView!
}
```

With **ViewComponents** you can easily create immutable values that represent the styling of the **whole view hierarchy** like this:

```swift
let buttonComponent = Component<UIButton>().button(
    .title("Test", for: .normal),
    .titleColor(.red, for: .normal)
)

let labelComponent = Component<UILabel>()
    .label(
        .text("MyLabel"),
        .font(.boldSystemFont(ofSize: 12))
    )
    .view(
        .backgroundColor(.blue)
    )

let iconComponent = Component<UIImageView>().imageView(
    .image(myImage)
)

let viewComponent = Component<MyCustomView>()
    .border(
        .color(.red), .width(3), .cornerRadius(12)
    )
    .child(buttonComponent, access: { $0.myButton })
    .child(labelComponent, access: { $0.myLabel })
    .child(iconComponent, access: { $0.myIcon })
```

and then when we need to apply our style we do the following:

```swift
viewComponent.configure(view: myCustomeView)
```

## Why Efficient?

The library provides diffing mechanism. Consider following 2 components

```swift
let button1 = Component<UIButton>().button(
    .title("Test", for: .normal),
    .titleColor(.red, for: .normal)
)

let button2 = Component<UIButton>().button(
    .title("Test", for: .normal),
    .titleColor(.blue, for: .normal),
    .adjustsImageWhenHighlighted(true)
)
```

We can apply only the difference to the view:

```swift
let changes = button1.diffChanges(from: button2)
```

Which in this case will be the following component:

```swift
let realChanges = Component<UIButton>().button(
    .titleColor(.blue, for: .normal),
    .adjustsImageWhenHighlighted(true)
)
```

The diffing will take the diffs for the all the subcomponents as well

## How to use with MVVM

Library provides a protocol `ComponentConvertible` that your ViewModels should can conform to and then it's easy to apply ViewModel to the the view. Here is an example of MVVM architecture from [here](https://www.objc.io/issues/13-architecture/mvvm/).

Imagine we have the following model:

```swift
struct Person {
    let salutation: String
    let firstName: String
    let lastName: String
    let birthday: Date
}
```

And we have the following view:

```swift
class PersonView: UIView {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthdateLabel: UILabel!
}
```

Now the View Model will look like this:

```swift
struct PersonViewModel: ComponentConvertible {
    let person: Person
    
    var name: String {
        return "\(person.salutation) \(person.firstName) \(person.lastName)"
    }
    
    var birthday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM d, yyyy"
        return formatter.string(from: person.birthday)
    }
    
    var toComponent: Component<PersonView> {
        return Component()
            .border(.color(.red), .width(12))
            .child(
                Component<UILabel>()
                .label(
                    .text(name),
                    .font(.boldSystemFont(ofSize: 12)),
                    .textColor(.red)
                ),
                access: { $0.nameLabel }
            )
            .child(
                Component<UILabel>()
                .view(
                    .backgroundColor(.yellow), .alpha(0.8)
                )
                .label(
                    .font(.systemFont(ofSize: 10)), .text(birthday)
                ),
                access: { $0.birthdateLabel }
            )
    }
}
```

And let's apply it:

```swift
let person: Person /// our Person model here
let view: PersonView /// our view
PersonViewModel(person: person).configure(view: view)
```

That's it!)

## Why easy to test?

In you unit tests, you just need to check for the equality the `ViewModels` `toComponent` value and your desired `Component`. And that's it. Something like the following:

```swift
let person = Person(salutation: "Hallo", firstName: "John", lastName: "Doe", birthday: Date())
let target = Component<PersonView>()
    .border(.color(.red), .width(12))
    .child(
        Component<UILabel>()
            .label(
                .text("Hallo John Doe"),
                .font(.boldSystemFont(ofSize: 12)),
                .textColor(.red)
            ),
        access: { $0.nameLabel }
    )
    .child(
        Component<UILabel>()
            .view(
                .backgroundColor(.yellow), .alpha(0.8)
            )
            .label(
                .font(.systemFont(ofSize: 10)), .text("Tuesday May 16, 2017")
            ),
        access: { $0.birthdateLabel }
    )

XCTAssertEqual(PersonViewModel(person: person).toComponent, target)
```

