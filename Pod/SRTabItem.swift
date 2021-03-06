//
//  SRTabItem.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Updated by Vincent Neo on 02/09/2018.
//
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabItem: NSButton {

	/// The delegate for the item
	weak var delegate: SRTabItemDelegate?

	/// The index of the item on the bar
	var index = 0

	var onImage : NSImage? = nil
	var offImage : NSImage? = nil
    var currentFont: NSFont? = nil
    
	/// The view controller associated with this item
	public var viewController: NSViewController?
    
	// MARK: - Initializers

    init(index: Int, viewController: NSViewController, imgPosition: ImagePosition?, font: NSFont?) {
		super.init(frame: NSZeroRect)

		self.index = index
		self.viewController = viewController
		wantsLayer = true
		isBordered = false
        
        if imgPosition == nil { // If position is not declared, default is loaded
            imagePosition = .imageAbove // Default: imageAbove
        }
        else {
            imagePosition = imgPosition!
        }

        if font == nil { // If font is not declared, default is loaded
            currentFont = NSFont.systemFont(ofSize: 10) // Default: size 10 system
        }
        else {
            currentFont = font!
        }
        
		setButtonType(.momentaryChange)

		if let title = viewController.title {
			attributedTitle = NSAttributedString(string: title, attributes: [
                NSAttributedStringKey.font: currentFont ?? NSFont.systemFont(ofSize: 10),
				NSAttributedStringKey.foregroundColor: NSColor.blue
				])
		} else {
			title = ""
			imagePosition = .imageOnly
		}
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func viewDidMoveToSuperview() {
		super.viewDidMoveToSuperview()

		target = self
		action = #selector(buttonPressed)
	}

	// MARK: - Actions

    @objc func buttonPressed() {
		delegate?.tabIndexShouldChangeTo(index: index)
	}

	func setTintColor(tint: NSColor) {

		attributedTitle = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font: currentFont ?? NSFont.systemFont(ofSize: 10),
			NSAttributedStringKey.foregroundColor: tint
			])

		guard let image = image else {
			Swift.print("Item has no image")
			return
		}

		image.lockFocus()
		tint.set()
		let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
		imageRect.fill(using: .sourceAtop)
		image.unlockFocus()

		self.image = image
	}


	func buttonOn() {
		self.image = onImage
	}

	func buttonOff() {
		self.image = offImage
	}

	override open func mouseEntered(with event: NSEvent) {
		alphaValue = 0.5
	}

	override open func mouseExited(with event: NSEvent) {
		alphaValue = 1
	}


}
