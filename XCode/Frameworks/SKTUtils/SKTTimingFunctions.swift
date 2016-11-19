/*
 * Timing static functions for SKTEffects. Based on Robert Penner's easing equations
 * http://robertpenner.com/easing/ and https://github.com/warrenm/AHEasing
 *
 * Copyright (c) 2013-2014 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import CoreGraphics

class SKTTimingFunctions {

    static func linear(_ t: CGFloat) -> CGFloat {
        return t
    }
    
    static func quadraticEaseIn(_ t: CGFloat) -> CGFloat {
        return t * t
    }
    
    static func quadraticEaseOut(_ t: CGFloat) -> CGFloat {
        return t * (2.0 - t)
    }
    
    static func quadraticEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 2.0 * t * t
        } else {
            let f = t - 1.0
            return 1.0 - 2.0 * f * f
        }
    }
    
    static func cubicEaseIn(_ t: CGFloat) -> CGFloat {
        return t * t * t
    }
    
    static func cubicEaseOut(_ t: CGFloat) -> CGFloat {
        let f = t - 1.0
        return 1.0 + f * f * f
    }
    
    static func cubicEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 4.0 * t * t * t
        } else {
            let f = t - 1.0
            return 1.0 + 4.0 * f * f * f
        }
    }
    
    static func quarticEaseIn(_ t: CGFloat) -> CGFloat {
        return t * t * t * t
    }
    
    static func quarticEaseOut(_ t: CGFloat) -> CGFloat {
        let f = t - 1.0
        return 1.0 - f * f * f * f
    }
    
    static func quarticEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 8.0 * t * t * t * t
        } else {
            let f = t - 1.0
            return 1.0 - 8.0 * f * f * f * f
        }
    }
    
    static func quinticEaseIn(_ t: CGFloat) -> CGFloat {
        return t * t * t * t * t
    }
    
    static func quinticEaseOut(_ t: CGFloat) -> CGFloat {
        let f = t - 1.0
        return 1.0 + f * f * f * f * f
    }
    
    static func quinticEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 16.0 * t * t * t * t * t
        } else {
            let f = t - 1.0
            return 1.0 + 16.0 * f * f * f * f * f
        }
    }
    
    static func sineEaseIn(_ t: CGFloat) -> CGFloat {
        return sin((t - 1.0) * π/2) + 1.0
    }
    
    static func sineEaseOut(_ t: CGFloat) -> CGFloat {
        return sin(t * π/2)
    }
    
    static func sineEaseInOut(_ t: CGFloat) -> CGFloat {
        return 0.5 * (1.0 - cos(t * π))
    }
    
    static func circularEaseIn(_ t: CGFloat) -> CGFloat {
        return 1.0 - sqrt(1.0 - t * t)
    }
    
    static func circularEaseOut(_ t: CGFloat) -> CGFloat {
        return sqrt((2.0 - t) * t)
    }
    
    static func circularEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
        } else {
            return 0.5 * sqrt(-4.0 * t * t + 8.0 * t - 3.0) + 0.5
        }
    }
    
    static func exponentialEaseIn(_ t: CGFloat) -> CGFloat {
        return (t == 0.0) ? t : pow(2.0, 10.0 * (t - 1.0))
    }
    
    static func exponentialEaseOut(_ t: CGFloat) -> CGFloat {
        return (t == 1.0) ? t : 1.0 - pow(2.0, -10.0 * t)
    }
    
    static func exponentialEaseInOut(_ t: CGFloat) -> CGFloat {
        if t == 0.0 || t == 1.0 {
            return t
        } else if t < 0.5 {
            return 0.5 * pow(2.0, 20.0 * t - 10.0)
        } else {
            return 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0)
        }
    }
    
    static func elasticEaseIn(_ t: CGFloat) -> CGFloat {
        return sin(13.0 * π/2 * t) * pow(2.0, 10.0 * (t - 1.0))
    }
    
    static func elasticEaseOut(_ t: CGFloat) -> CGFloat {
        return sin(-13.0 * π/2 * (t + 1.0)) * pow(2.0, -10.0 * t) + 1.0
    }
    
    static func elasticEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 0.5 * sin(13.0 * π * t) * pow(2.0, 20.0 * t - 10.0)
        } else {
            return 0.5 * sin(-13.0 * π * t) * pow(2.0, -20.0 * t + 10.0) + 1.0
        }
    }
    
    static func backEaseIn(_ t: CGFloat) -> CGFloat {
        let s: CGFloat = 1.70158
        return ((s + 1.0) * t - s) * t * t
    }
    
    static func backEaseOut(_ t: CGFloat) -> CGFloat {
        let s: CGFloat = 1.70158
        let f = 1.0 - t
        return 1.0 - ((s + 1.0) * f - s) * f * f
    }
    
    static func backEaseInOut(_ t: CGFloat) -> CGFloat {
        let s: CGFloat = 1.70158
        if t < 0.5 {
            let f = 2.0 * t
            return 0.5 * ((s + 1.0) * f - s) * f * f
        } else {
            let f = 2.0 * (1.0 - t)
            return 1.0 - 0.5 * ((s + 1.0) * f - s) * f * f
        }
    }
    
    static func extremeBackEaseIn(_ t: CGFloat) -> CGFloat {
        return (t * t - sin(t * π)) * t
    }
    
    static func extremeBackEaseOut(_ t: CGFloat) -> CGFloat {
        let f = 1.0 - t
        return 1.0 - (f * f - sin(f * π)) * f
    }
    
    static func extremeBackEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            let f = 2.0 * t
            return 0.5 * (f * f - sin(f * π)) * f
        } else {
            let f = 2.0 * (1.0 - t)
            return 1.0 - 0.5 * (f * f - sin(f * π)) * f
        }
    }
    
    static func bounceEaseIn(_ t: CGFloat) -> CGFloat {
        return 1.0 - bounceEaseOut(1.0 - t)
    }
    
    static func bounceEaseOut(_ t: CGFloat) -> CGFloat {
        if t < 1.0 / 2.75 {
            return 7.5625 * t * t
        } else if t < 2.0 / 2.75 {
            let f = t - 1.5 / 2.75
            return 7.5625 * f * f + 0.75
        } else if t < 2.5 / 2.75 {
            let f = t - 2.25 / 2.75
            return 7.5625 * f * f + 0.9375
        } else {
            let f = t - 2.625 / 2.75
            return 7.5625 * f * f + 0.984375
        }
    }
    
    static func bounceEaseInOut(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 0.5 * bounceEaseIn(t * 2.0)
        } else {
            return 0.5 * bounceEaseOut(t * 2.0 - 1.0) + 0.5
        }
    }
    
    static func smoothstep(_ t: CGFloat) -> CGFloat {
        return t * t * (3 - 2 * t)
    }
    
    static func createShakeFunction(_ oscillations: Int) -> (CGFloat) -> CGFloat {
        return {t in -pow(2.0, -10.0 * t) * sin(t * π * CGFloat(oscillations) * 2.0) + 1.0}
    }
}
