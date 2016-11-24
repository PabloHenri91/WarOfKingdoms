//
//  BoxPlayerLevel.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/10/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class BoxPlayerXP: Button {
    
    var text: String {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    
    private var label: Label
    
    init() {
        
        self.label = Label(text: "?/?", fontSize: .fontSize8, x: 72, y: 7)
        
        //boxWhite144x21
        super.init(imageNamed: "boxWhite144x13", x: 3, y: 37, horizontalAlignment: .left, verticalAlignment: .top)
        
        self.addChild(self.label)
        
        self.touchUpEvent = { [weak self] in
            guard let boxPlayerXP = self else { return }
            boxPlayerXP.isHidden = !boxPlayerXP.isHidden
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
