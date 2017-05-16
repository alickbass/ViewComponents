# ViewComponents
Declarative view components

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![Build Status](https://travis-ci.org/alickbass/ViewComponents.svg?branch=master)](https://travis-ci.org/alickbass/ViewComponents)
[![codecov](https://codecov.io/gh/alickbass/ViewComponents/branch/master/graph/badge.svg)](https://codecov.io/gh/alickbass/ViewComponents)

## What is ViewComponents

ViewComponents is a library that helps you to create View Models that are:

* [**Declarative**](#why-declarative)
* [**Composable**](#why-composable)
* [**Perfect fit to MVVM architecture**](#how-to-use-with-mvvm)
* **Easy to test**

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
    .child(buttonComponent, { $0.myButton })
    .child(labelComponent, { $0.myLabel })
    .child(iconComponent, { $0.myIcon })
```

and then when we need to apply our style we do the following:

```swift
viewComponent.configure(view: myCustomeView)
```

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
        let name = Component<UILabel>().label(
            .text(self.name),
            .font(.boldSystemFont(ofSize: 12)),
            .textColor(.red)
        )
    
        let birthday = Component<UILabel>().label(
            .text(self.birthday),
            .font(.boldSystemFont(ofSize: 12)),
            .textColor(.red)
        )
        
        return Component()
            .border(.color(.red), .width(12))
            .child(name, { $0.nameLabel })
            .child(birthday, { $0.birthdateLabel })
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
