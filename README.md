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
* [**Easy to support custom views and types**](#why-easy-to-support-custom-views)

## Why declarative?

You describe how the view should look like and the library will take care to applying the styling. Here's an example:

```swift
let buttonComponent = Component<UIButton>(
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
let labelComponent = Component<UILabel>(
    .text("MyLabel"),
    .font(.boldSystemFont(ofSize: 12)),
    .backgroundColor(.blue)
)

let viewComponent = Component<MyCustomView>(
    .border(cornerRadius: 12, width: 3, color: .red)
).withChildren(
    .child({ $0.myButton }, styles:
        .title("Test", for: .normal),
        .titleColor(.red, for: .normal)
    ),
    .child({ $0.myLabel }, labelComponent),
    .child({ $0.myIcon }, styles:
        .image(myImage)
    )
)
```

and then when we need to apply our style we do the following:

```swift
viewComponent.configure(view: myCustomeView)
```

## Why Efficient?

The library provides diffing mechanism. Consider following 2 components

```swift
let button1 = Component<UIButton>(
    .title("Test", for: .normal),
    .titleColor(.red, for: .normal)
)

let button2 = Component<UIButton>(
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
let realChanges = Component<UIButton>(
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
        return Component(
            .border(width: 12, color: .red)
        ).withChildren(
            .child({ $0.nameLabel }, styles:
                .text(name),
                .font(.boldSystemFont(ofSize: 12)),
                .textColor(.red)
            ),
            .child({ $0.birthdateLabel }, styles:
                .backgroundColor(.yellow), .alpha(0.8),
                .font(.systemFont(ofSize: 10)), .text(birthday)
            )
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

let target = Component<PersonView>(
    .border(width: 12, color: .red)
).withChildren(
    .child({ $0.nameLabel }, styles:
        .text("Hallo John Doe"),
        .font(.boldSystemFont(ofSize: 12)),
        .textColor(.red)
    ),
    .child({ $0.birthdateLabel }, styles:
        .backgroundColor(.yellow), .alpha(0.8),
        .font(.systemFont(ofSize: 10)), .text("Tuesday May 16, 2017")
    )
)

XCTAssertEqual(PersonViewModel(person: person).toComponent, target)
```

## Why easy to support custom views?

Let's imagine that you have the following custom class with a property `isShiny`:

```swift
class MyCustomView: UIView {
    var isShiny: Bool = true {
        didSet {
            // Do some magic stuff here
        }
    }
}
```

In order for ViewComponents to support `MyCustomView` we need to add the following code:

```swift
private enum MyCustomViewStyleKey: Int {
    case isShiny
}

extension AnyStyle where T: MyCustomView {
    private typealias ViewStyle<Item> = Style<T, Item, MyCustomViewStyleKey>
    
    static func isShiny(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isShiny, sideEffect: { $0.isShiny = $1 }).toAnyStyle
    }
}
```

Let's take a closer look at what we did:

1. We need to declare a `Int enum` that will contain the keys for every propery we want to support. In our case it's `MyCustomViewStyleKey`
2. We need to make an extension to `AnyStyle` where generic type is `MyCustomView` or it's subclass
3. For convenienve we define `typealias ViewStyle<Item>`
4. We need to implement static function that will contain our side effect. We provide the value (in our case it's a `Bool`), key (in our case `MyCustomViewStyleKey.isShiny`) and a side effect function, that take 2 parameters: the view of type `T` and the value which is boolean in our case.

And that's it.

Now we can use our `MyCustomView` just as any other type:

```swift
let customView = Component<MyCustomView>(
    .isShiny(true)
)
```
