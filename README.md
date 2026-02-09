# AutoLayoutWoot

A lightweight wrapper for Auto Layout.

## Sample Code

Here's some standard Auto Layout code to add a label to the top-left corner of a view:

```swift
let label = UILabel()
label.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(label)
label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
```

And here's that same layout defined using AutoLayoutWoot

```swift
let label = UILabel()
label.layout(in: view)
    .left()
    .right()
```

## Design Goals

1. **Easy to write.** Writing Auto Layout code should be fast, intuitive, and fun.
2. **Easy to read.** You should be able to glance at the code and quickly understand the layout.
3. **Good Autocomplete.**

## Why bother?

### What's wrong with Apple's default Auto Layout code syntax?

It is too verbose, which makes it cumbersome to read and write.

### Why not simply use Interface Builder to visually build layouts in XIB or Storyboard files?

TODO: fill this in.

### Why not simply use SnapKit?

TODO: fill this in.


## References

1. [Apple's Auto Layout Guide] (https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1)
