//
//  CleanTextField.swift
//  SubTrack
//
//  Created by Stanislas Sodonon on 6/12/17.
//  Copyright © 2017 Stanislas Sodonon. All rights reserved.
//

import Cocoa

protocol SubTextField: class {
    func setData()
}

class CleanTextField: NSTextField {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.isBordered = false
        self.drawsBackground = false
        self.lineBreakMode = NSParagraphStyle.LineBreakMode.byTruncatingTail
        self.isEditable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

class CleanIntField: CleanTextField {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.alignment = NSTextAlignment.right
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DurationField: CleanIntField {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func secondsToDaysHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int, Int) {
        return (
            seconds / (60*60*24),
            (seconds % (60*60*24)) / (60*60),
            ((seconds % (60*60*24)) % (60*60)) / 60,
            ((seconds % (60*60*24)) % (60*60)) % 60
        )
    }
    
    func formatShort(duration: Int) {
        let (d, h, m, s) = secondsToDaysHoursMinutesSeconds(seconds: duration)
        let d_ = d > 0 ? "\(d):" : ""
        let h_ = h > 0 ? "\(h):" : ""
        let m_ = m > 0 ? "\(m):" : ""
        let s_ = String(format: "%02d", s)
        
        let string = d_ + h_ + m_ + s_
        self.stringValue = string
    }
    
    func formatLong(duration: Int) {
        let (d, h, m, s) = secondsToDaysHoursMinutesSeconds(seconds: duration)
        let d_ = d > 0 ? "\(d) day(s) " : ""
        let h_ = h > 0 ? "\(h) hour(s) " : ""
        let m_ = m > 0 ? "\(m) minutes(s) " : ""
        let s_ = "\(s) second(s)"
        
        let string = d_ + h_ + m_ + s_
        self.stringValue = string
    }
}

class IconCellView: NSStackView {
    
    let iconView = NSImageView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.orientation = NSUserInterfaceLayoutOrientation.horizontal
        self.spacing = 10
        self.addView(self.iconView, in: NSStackView.Gravity.trailing)
        self.iconView.image = NSImage(named: NSImage.Name.user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SubduedField: CleanTextField {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.textColor = NSColor.disabledControlTextColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class PillField: SubduedField {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
//        self.isBordered = true
        self.alignment = NSTextAlignment.right
        self.font = NSFont.controlContentFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class CommonLabelField: NSView {
    let textField = CleanTextField()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        textField.font = NSFont.boldSystemFont(ofSize: 12)
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
    }
    
    func sizeToFit() {
        fixHeight(view: textField)
        textField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        self.needsUpdateConstraints = true
    }
    
    func fixHeight(view: NSView) {
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LabelTextField: CommonLabelField {
    let pillField = PillField()
    let bottomLine = NSBox()
//    let wrapper = NSView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        bottomLine.boxType = NSBox.BoxType.separator
        pillField.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
//        wrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pillField)
        self.addSubview(bottomLine)
//        self.addSubview(wrapper)
    }
    
    override func sizeToFit() {
        fixHeight(view: pillField)
        fixHeight(view: textField)
        let pillWidth: CGFloat = 40
        let padding: CGFloat = -10
        
        pillField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: padding).isActive = true
        pillField.widthAnchor.constraint(equalToConstant: pillWidth).isActive = true
        
        textField.rightAnchor.constraint(equalTo: pillField.leftAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.needsUpdateConstraints = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SectionHeaderField: CommonLabelField {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.textField.font = NSFont.boldSystemFont(ofSize: 14)

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class NavMenuField: NSTableCellView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let text = CleanTextField()
        self.addSubview(text)
        
        let icon = NSImageView()
        icon.image = NSImage(named: NSImage.Name.quickLookTemplate)
        self.imageView = icon
        self.addSubview(icon)

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
