/*
 * Copyright (C)2017 Markus Raab (derRaab) | blog.derraab.com | superclass.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package de.superclass.haxe.openfl.util;

import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.geom.Rectangle;

/**
	`DisplayObjectContainerUtil` provides simple helper methods to work with `DisplayObjectContainer` instances.
**/
class DisplayObjectContainerUtil {

    public static function getRightmostNestedDisplayObject( displayObjectContainer : DisplayObjectContainer, ?targetCoordinateSpace : DisplayObject = null ) : DisplayObject {

        if ( targetCoordinateSpace == null ) {

            targetCoordinateSpace = displayObjectContainer;
        }

        var numChildren : Int = displayObjectContainer.numChildren;
        if ( 0 < numChildren ) {

            var rightMostChild : DisplayObject = null;
            var rightMostChildBounds : Rectangle = null;

            for ( i in 0...numChildren ) {

                var child : DisplayObject = displayObjectContainer.getChildAt( i );
                var childBounds : Rectangle = child.getBounds( targetCoordinateSpace );

                if ( rightMostChildBounds == null || rightMostChildBounds.right < childBounds.right ) {

                    rightMostChild = child;
                    rightMostChildBounds = childBounds;
                }
            }

            if ( Std.isOfType( rightMostChild, DisplayObjectContainer ) ) {

                rightMostChild = getRightmostNestedDisplayObject( cast rightMostChild, targetCoordinateSpace );
            }

            return rightMostChild;
        }

        return displayObjectContainer;
    }
}
