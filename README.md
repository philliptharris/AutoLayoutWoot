# AutoLayoutWoot

A lightweight, intuitive wrapper for Auto Layout that makes constraint-based layouts fast to write and easy to read.

## Why AutoLayoutWoot?

**Apple's Auto Layout is powerful but verbose.** Every constraint requires multiple lines of boilerplate. **SnapKit improves things but adds unnecessary complexity** with closures and verbose chaining. **TinyConstraints gets close but becomes repetitive** and pollutes UIView's namespace.

**AutoLayoutWoot** takes a different approach: establish context once, then chain constraints naturally without repetition or ceremony.

## Quick Example

Here's how you position a label in the top-left corner:

**Apple's default syntax:**
```swift
let label = UILabel()
label.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(label)
label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
```

**SnapKit:**
```swift
let label = UILabel()
view.addSubview(label)
label.snp.makeConstraints { make in
    make.left.equalTo(view)
    make.top.equalTo(view)
}
```

**TinyConstraints:**
```swift
let label = UILabel()
view.addSubview(label)
label.leftToSuperview()
label.topToSuperview()
```

**AutoLayoutWoot:**
```swift
let label = UILabel()
label.layout(in: view)
    .left()
    .top()
```

## More Examples

### Centering a View

**Apple's default syntax:**
```swift
let box = UIView()
box.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(box)
box.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
box.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
box.widthAnchor.constraint(equalToConstant: 100).isActive = true
box.heightAnchor.constraint(equalToConstant: 100).isActive = true
```

**SnapKit:**
```swift
let box = UIView()
view.addSubview(box)
box.snp.makeConstraints { make in
    make.center.equalTo(view)
    make.width.equalTo(100)
    make.height.equalTo(100)
}
```

**TinyConstraints:**
```swift
let box = UIView()
view.addSubview(box)
box.centerInSuperview()
box.width(100)
box.height(100)
```

**AutoLayoutWoot:**
```swift
let box = UIView()
box.layout(in: view)
    .center()
    .width(100)
    .height(100)
```

### Full-Size View (Pin to All Edges)

**Apple's default syntax:**
```swift
let container = UIView()
container.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(container)
container.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
container.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
```

**SnapKit:**
```swift
let container = UIView()
view.addSubview(container)
container.snp.makeConstraints { make in
    make.edges.equalTo(view)
}
```

**TinyConstraints:**
```swift
let container = UIView()
view.addSubview(container)
container.edgesToSuperview()
```

**AutoLayoutWoot:**
```swift
let container = UIView()
container.layout(in: view)
    .edges()
```

### View with Margins

**Apple's default syntax:**
```swift
let box = UIView()
box.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(box)
box.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
box.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
box.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
box.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
```

**SnapKit:**
```swift
let box = UIView()
view.addSubview(box)
box.snp.makeConstraints { make in
    make.edges.equalTo(view).inset(20)
}
```

**TinyConstraints:**
```swift
let box = UIView()
view.addSubview(container)
box.edgesToSuperview(insets: .uniform(20))
```

**AutoLayoutWoot:**
```swift
let box = UIView()
box.layout(in: view)
    .edges(inset: 20)
```

### Positioning Relative to Another View

**Apple's default syntax:**
```swift
let label = UILabel()
label.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(label)
label.leftAnchor.constraint(equalTo: button.leftAnchor).isActive = true
label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8).isActive = true
```

**SnapKit:**
```swift
let label = UILabel()
view.addSubview(label)
label.snp.makeConstraints { make in
    make.left.equalTo(button)
    make.top.equalTo(button.snp.bottom).offset(8)
}
```

**TinyConstraints:**
```swift
let label = UILabel()
view.addSubview(label)
label.left(to: button)
label.topToBottom(of: button, offset: 8)
```

**AutoLayoutWoot:**
```swift
let label = UILabel()
label.layout(in: view)
    .left(to: button)
    .top(to: button.bottom, offset: 8)
```

### Fixed Size, Centered

**Apple's default syntax:**
```swift
let button = UIButton()
button.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(button)
button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
button.widthAnchor.constraint(equalToConstant: 200).isActive = true
button.heightAnchor.constraint(equalToConstant: 44).isActive = true
```

**SnapKit:**
```swift
let button = UIButton()
view.addSubview(button)
button.snp.makeConstraints { make in
    make.center.equalTo(view)
    make.width.equalTo(200)
    make.height.equalTo(44)
}
```

**TinyConstraints:**
```swift
let button = UIButton()
view.addSubview(button)
button.centerInSuperview()
button.width(200)
button.height(44)
```

**AutoLayoutWoot:**
```swift
let button = UIButton()
button.layout(in: view)
    .center()
    .size(width: 200, height: 44)
```

## Design Philosophy

### 1. Establish Context Once

Instead of repeating "toSuperview" or passing view references constantly, AutoLayoutWoot establishes the layout context upfront:

```swift
view.layout(in: superview)  // Context established
    .left()                 // Relative to superview
    .top()                  // Also relative to superview
```

This handles three things automatically:
- Sets `translatesAutoresizingMaskIntoConstraints = false`
- Calls `superview.addSubview(view)`
- Establishes what constraints are relative to

### 2. No Namespace Pollution

Rather than extending UIView with dozens of layout methods (which clutter autocomplete), AutoLayoutWoot uses a dedicated layout object. All layout methods live in one clean namespace that only appears when you call `.layout()`.

### 3. Terse for Common Cases, Clear for Complex Ones

Common constraints use short, intuitive names:
- `.left()`, `.right()`, `.top()`, `.bottom()`
- `.center()`, `.edges()`
- `.width()`, `.height()`, `.size()`

More complex constraints become slightly more descriptive to avoid ambiguity:
- `.left(to: otherView)`
- `.top(to: otherView.bottom, offset: 8)`
- `.width(equalTo: otherView, multiplier: 0.5)`

### 4. No Unnecessary Ceremony

No cryptic prefixes like `snp`. No closure nesting. No verbose chaining like `.equalTo()` when the intent is already clear.

Compare:
```swift
// SnapKit: Why "snp"? Why "equalTo" when "=" is implied?
make.height.equalTo(100)

// AutoLayoutWoot: Direct and clear
.height(100)
```

## Design Goals

1. **Easy to write.** Writing Auto Layout code should be fast, intuitive, and fun.
2. **Easy to read.** You should be able to glance at the code and quickly understand the layout.
3. **Good Autocomplete.** Layout methods live in a dedicated namespace, keeping your autocomplete clean and focused.
4. **Minimal boilerplate.** Handle `translatesAutoresizingMaskIntoConstraints` and `addSubview` automatically.
5. **Natural chaining.** Chain constraints when it reads naturally, but avoid over-chaining that obscures meaning.

## Why Not Just Use...?

### Apple's Default Auto Layout Syntax?

**Too verbose.** Every constraint requires:
- Setting `translatesAutoresizingMaskIntoConstraints = false`
- Manually calling `addSubview()`
- Creating constraint objects
- Setting `isActive = true`

This turns 2 conceptual constraints into 5+ lines of code.

### Interface Builder (XIBs/Storyboards)?

While visual layout tools have their place, programmatic Auto Layout offers:
- **Better merge conflict resolution** (text vs. XML)
- **Easier code review** (readable diffs)
- **Type safety and refactoring support**
- **Dynamic layouts** that respond to runtime conditions
- **Reusable layout code** across multiple screens

AutoLayoutWoot makes programmatic layout as convenient as it should be.

### SnapKit?

SnapKit was a major improvement, but has some issues:

**1. The `snp` prefix is cryptic.** Is it "SnapKit"? Why abbreviate at all? It's visual noise that doesn't add clarity.

**2. Verbose chaining.** Why write `make.height.equalTo(100)` when you could write `height(100)`? The `.equalTo()` is implied—it adds characters without adding meaning.

**3. Closure ceremony.** The `makeConstraints` closure with a `make` parameter adds nesting and ceremony:
```swift
view.snp.makeConstraints { make in
    make.left.equalTo(superview)
    make.top.equalTo(superview)
}
```

This is better than Apple's syntax, but still has more ceremony than necessary.

### TinyConstraints?

TinyConstraints gets very close to the ideal API, but has two issues:

**1. Repetitive "ToSuperview".** When all your constraints are relative to the superview, you end up repeating yourself:
```swift
box.leftToSuperview()
box.rightToSuperview()
box.topToSuperview()
box.bottomToSuperview()
```

**2. UIView namespace pollution.** TinyConstraints extends UIView directly with layout methods, which means your autocomplete shows `left()`, `right()`, `center()`, `width()`, etc. intermingled with all of UIView's existing methods and properties. This clutters autocomplete and makes it harder to find what you're looking for.

AutoLayoutWoot solves both by establishing context once (`.layout(in: view)`) and keeping all layout methods in a dedicated namespace.

## Installation

### Swift Package Manager

Add AutoLayoutWoot to your project through Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/yourusername/AutoLayoutWoot`

Or add to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/yourusername/AutoLayoutWoot", from: "1.0.0")
]
```

## Requirements

- iOS 12.0+
- Swift 5.0+

## License

MIT License. See LICENSE file for details.

## References

1. [Apple's Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html)
2. [SnapKit](https://github.com/SnapKit/SnapKit)
3. [TinyConstraints](https://github.com/roberthein/TinyConstraints)
