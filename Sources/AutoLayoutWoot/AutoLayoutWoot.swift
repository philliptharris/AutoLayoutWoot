import UIKit

// MARK: - LayoutContext

/// A context object that provides a fluent API for creating Auto Layout constraints.
public class LayoutContext {
    private let view: UIView
    private let referenceView: UIView?
    private var createdConstraints: [NSLayoutConstraint] = []
    
    init(view: UIView, referenceView: UIView?) {
        self.view = view
        self.referenceView = referenceView
    }
    
    /// Returns all constraints created by this layout context
    public var constraints: [NSLayoutConstraint] {
        return createdConstraints
    }
    
    private func addConstraint(_ constraint: NSLayoutConstraint) {
        createdConstraints.append(constraint)
    }
    
    /// Switches to a different reference view for subsequent constraints
    @discardableResult
    public func layout(relativeTo view: UIView) -> LayoutContext {
        let newContext = LayoutContext(view: self.view, referenceView: view)
        newContext.createdConstraints = self.createdConstraints
        return newContext
    }
    
    // MARK: - Edge Constraints
    
    /// Constrains the top edge to the reference view's top
    @discardableResult
    public func top(offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set. Use layout(addingTo:) or layout(relativeTo:) first.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .top,
            relatedBy: relation,
            toItem: reference,
            attribute: .top,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the top edge to at least the specified offset (greaterThanOrEqual)
    @discardableResult
    public func top(atLeast offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return top(offset: offset, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the top edge to at most the specified offset (lessThanOrEqual)
    @discardableResult
    public func top(atMost offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return top(offset: offset, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the top edge to the reference view's safe area top
    @discardableResult
    public func topToSafeArea(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.topAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.topAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the top edge to the reference view's layout margin top
    @discardableResult
    public func topToMargin(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.topAnchor.constraint(equalTo: reference.layoutMarginsGuide.topAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the left edge to the reference view's left
    @discardableResult
    public func left(offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .left,
            relatedBy: relation,
            toItem: reference,
            attribute: .left,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the left edge to at least the specified offset
    @discardableResult
    public func left(atLeast offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return left(offset: offset, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the left edge to at most the specified offset
    @discardableResult
    public func left(atMost offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return left(offset: offset, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the left edge to the reference view's safe area left
    @discardableResult
    public func leftToSafeArea(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.leftAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.leftAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the left edge to the reference view's layout margin left
    @discardableResult
    public func leftToMargin(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.leftAnchor.constraint(equalTo: reference.layoutMarginsGuide.leftAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the bottom edge to the reference view's bottom
    @discardableResult
    public func bottom(offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .bottom,
            relatedBy: relation,
            toItem: reference,
            attribute: .bottom,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the bottom edge to at least the specified offset
    @discardableResult
    public func bottom(atLeast offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return bottom(offset: offset, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the bottom edge to at most the specified offset
    @discardableResult
    public func bottom(atMost offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return bottom(offset: offset, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the bottom edge to the reference view's safe area bottom
    @discardableResult
    public func bottomToSafeArea(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.bottomAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.bottomAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the bottom edge to the reference view's layout margin bottom
    @discardableResult
    public func bottomToMargin(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.bottomAnchor.constraint(equalTo: reference.layoutMarginsGuide.bottomAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the right edge to the reference view's right
    @discardableResult
    public func right(offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .right,
            relatedBy: relation,
            toItem: reference,
            attribute: .right,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the right edge to at least the specified offset
    @discardableResult
    public func right(atLeast offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return right(offset: offset, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the right edge to at most the specified offset
    @discardableResult
    public func right(atMost offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return right(offset: offset, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the right edge to the reference view's safe area right
    @discardableResult
    public func rightToSafeArea(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.rightAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.rightAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the right edge to the reference view's layout margin right
    @discardableResult
    public func rightToMargin(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.rightAnchor.constraint(equalTo: reference.layoutMarginsGuide.rightAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the leading edge to the reference view's leading
    @discardableResult
    public func leading(offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .leading,
            relatedBy: relation,
            toItem: reference,
            attribute: .leading,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the leading edge to at least the specified offset
    @discardableResult
    public func leading(atLeast offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return leading(offset: offset, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the leading edge to at most the specified offset
    @discardableResult
    public func leading(atMost offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return leading(offset: offset, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the leading edge to the reference view's safe area leading
    @discardableResult
    public func leadingToSafeArea(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.leadingAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.leadingAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the leading edge to the reference view's layout margin leading
    @discardableResult
    public func leadingToMargin(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.leadingAnchor.constraint(equalTo: reference.layoutMarginsGuide.leadingAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the trailing edge to the reference view's trailing
    @discardableResult
    public func trailing(offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .trailing,
            relatedBy: relation,
            toItem: reference,
            attribute: .trailing,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the trailing edge to at least the specified offset
    @discardableResult
    public func trailing(atLeast offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return trailing(offset: offset, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the trailing edge to at most the specified offset
    @discardableResult
    public func trailing(atMost offset: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return trailing(offset: offset, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Constrains the trailing edge to the reference view's safe area trailing
    @discardableResult
    public func trailingToSafeArea(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.trailingAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.trailingAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Constrains the trailing edge to the reference view's layout margin trailing
    @discardableResult
    public func trailingToMargin(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = view.trailingAnchor.constraint(equalTo: reference.layoutMarginsGuide.trailingAnchor, constant: offset)
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    // MARK: - Relative Positioning (Edge to Opposite Edge)
    
    /// Positions the left edge to the right of the reference view
    @discardableResult
    public func leftToRight(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .left,
            relatedBy: .equal,
            toItem: reference,
            attribute: .right,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Positions the right edge to the left of the reference view
    @discardableResult
    public func rightToLeft(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .right,
            relatedBy: .equal,
            toItem: reference,
            attribute: .left,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Positions the top edge below the reference view
    @discardableResult
    public func topToBottom(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .top,
            relatedBy: .equal,
            toItem: reference,
            attribute: .bottom,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Positions the bottom edge above the reference view
    @discardableResult
    public func bottomToTop(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: reference,
            attribute: .top,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    // MARK: - Size Constraints
    
    /// Sets the width to a fixed value
    @discardableResult
    public func width(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .width,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Sets the width to at least the specified value
    @discardableResult
    public func width(atLeast constant: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return width(constant, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Sets the width to at most the specified value
    @discardableResult
    public func width(atMost constant: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return width(constant, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Sets the width equal to another view's width
    @discardableResult
    public func width(equalTo otherView: UIView, multiplier: CGFloat = 1.0, offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: otherView,
            attribute: .width,
            multiplier: multiplier,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Sets the height to a fixed value
    @discardableResult
    public func height(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .height,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Sets the height to at least the specified value
    @discardableResult
    public func height(atLeast constant: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return height(constant, relation: .greaterThanOrEqual, priority: priority, active: active)
    }
    
    /// Sets the height to at most the specified value
    @discardableResult
    public func height(atMost constant: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return height(constant, relation: .lessThanOrEqual, priority: priority, active: active)
    }
    
    /// Sets the height equal to another view's height
    @discardableResult
    public func height(equalTo otherView: UIView, multiplier: CGFloat = 1.0, offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: otherView,
            attribute: .height,
            multiplier: multiplier,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Sets both width and height to the same value
    @discardableResult
    public func size(_ constant: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return width(constant, priority: priority, active: active)
            .height(constant, priority: priority, active: active)
    }
    
    /// Sets width and height to specific values
    @discardableResult
    public func size(width: CGFloat, height: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return self.width(width, priority: priority, active: active)
            .height(height, priority: priority, active: active)
    }
    
    /// Sets the aspect ratio (width / height)
    @discardableResult
    public func aspectRatio(_ ratio: CGFloat, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: ratio,
            constant: 0
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    // MARK: - Composite Constraints
    
    /// Pins all edges to the reference view
    @discardableResult
    public func edges(inset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return top(offset: inset, priority: priority, active: active)
            .left(offset: inset, priority: priority, active: active)
            .bottom(offset: -inset, priority: priority, active: active)
            .right(offset: -inset, priority: priority, active: active)
    }
    
    /// Pins all edges to the reference view with specific insets
    @discardableResult
    public func edges(insets: UIEdgeInsets, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return top(offset: insets.top, priority: priority, active: active)
            .left(offset: insets.left, priority: priority, active: active)
            .bottom(offset: -insets.bottom, priority: priority, active: active)
            .right(offset: -insets.right, priority: priority, active: active)
    }
    
    /// Pins all edges to the reference view's safe area
    @discardableResult
    public func edgesToSafeArea(inset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return topToSafeArea(offset: inset, priority: priority, active: active)
            .leftToSafeArea(offset: inset, priority: priority, active: active)
            .bottomToSafeArea(offset: -inset, priority: priority, active: active)
            .rightToSafeArea(offset: -inset, priority: priority, active: active)
    }
    
    /// Pins all edges to the reference view's layout margins
    @discardableResult
    public func edgesToMargins(inset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return topToMargin(offset: inset, priority: priority, active: active)
            .leftToMargin(offset: inset, priority: priority, active: active)
            .bottomToMargin(offset: -inset, priority: priority, active: active)
            .rightToMargin(offset: -inset, priority: priority, active: active)
    }
    
    /// Centers both horizontally and vertically
    @discardableResult
    public func center(offsetX: CGFloat = 0, offsetY: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        return centerX(offset: offsetX, priority: priority, active: active)
            .centerY(offset: offsetY, priority: priority, active: active)
    }
    
    /// Centers horizontally
    @discardableResult
    public func centerX(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: reference,
            attribute: .centerX,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
    
    /// Centers vertically
    @discardableResult
    public func centerY(offset: CGFloat = 0, priority: UILayoutPriority = .required, active: Bool = true) -> LayoutContext {
        guard let reference = referenceView else {
            assertionFailure("No reference view set.")
            return self
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: reference,
            attribute: .centerY,
            multiplier: 1.0,
            constant: offset
        )
        constraint.priority = priority
        constraint.isActive = active
        addConstraint(constraint)
        return self
    }
}

// MARK: - UIView Extension

public extension UIView {
    /// Returns a layout context for self-relative constraints (size, aspect ratio)
    func layout() -> LayoutContext {
        translatesAutoresizingMaskIntoConstraints = false
        return LayoutContext(view: self, referenceView: nil)
    }
    
    /// Adds this view to the specified superview and returns a layout context
    func layout(addingTo superview: UIView) -> LayoutContext {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        return LayoutContext(view: self, referenceView: superview)
    }
    
    /// Returns a layout context relative to the superview (assumes view is already added)
    func layoutInSuperview() -> LayoutContext {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else {
            assertionFailure("layoutInSuperview() called but view has no superview")
            return LayoutContext(view: self, referenceView: nil)
        }
        return LayoutContext(view: self, referenceView: superview)
    }
    
    /// Returns a layout context relative to another view
    func layout(relativeTo view: UIView) -> LayoutContext {
        translatesAutoresizingMaskIntoConstraints = false
        return LayoutContext(view: self, referenceView: view)
    }
}
