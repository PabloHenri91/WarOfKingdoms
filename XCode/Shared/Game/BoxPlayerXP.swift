//
//  BoxPlayerLevel.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/10/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class BoxPlayerXP: Button {
    
    init() {
        super.init(imageNamed: "boxWhite144x13", x: 3, y: 37, horizontalAlignment: .left, verticalAlignment: .top)
        
        self.label?.fontSize = .fontSize8
        
        self.addHandler { [weak self] in
            guard let boxPlayerXP = self else { return }
            boxPlayerXP.isHidden = !boxPlayerXP.isHidden
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
