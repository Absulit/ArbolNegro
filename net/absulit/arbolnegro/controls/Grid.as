  /**
	ArbolNegro - actionscript3 multipurpose code
    Copyright (C) 2012  Sebastián Sanabria Díaz - arbolnegro.absulit.net - arbolnegroaAS3@gmail.com - admin@absulit.net

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
   */

package  net.absulit.arbolnegro.controls{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.absulit.arbolnegro.data.CircularList;
	import net.absulit.arbolnegro.interfaces.Destroy;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class Grid extends Sprite implements Destroy {
		protected var _width:uint;
		protected var _height:uint;
		protected var _rows:Vector.<Vector.<DisplayObject>>;
		public function Grid() {
			super();
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			_width = 400;
			_height = 400;
			_rows = new Vector.<Vector.<DisplayObject>>();
		}
		
		
		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);			
		}
		
		/**
		 * MUST call function from Grid; it will update the items.
		 * Every change, a call to this function; new items? sort()
		 * new dimensions? sort()
		 */
		public function sort():void {
			if (numChildren == 0) {
				throw new Error("You must add at least one DisplayObjet with addChild or addChildAt");
			}
			var previousX:uint = 0;
			var previousY:uint = 0;
			var previousW:uint = 0;
			var previousH:uint = 0;
			
			var newX:uint = 0;
			var newY:uint = 0;
			var item:DisplayObject;
			_rows = new Vector.<Vector.<DisplayObject>>();
			var row:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			for (var k:uint = 0; k < this.numChildren ; k++ ) {
				item = this.getChildAt(k);
				if (item.visible) {
					//the new item's position based on the previous item x and width
					newX = previousX + previousW;		
					//if the new item to be sorted overpass the width limit
					//it corresponds to the new row
					if ((newX + item.width) > _width) {
						newX = 0;
						newY = previousY + previousH;
						//finished line, push new row and create new empty one
						_rows.push(row);
						row = new Vector.<DisplayObject>();
						row.push(item);
					}else {
						//
						row.push(item);
					}
					item.x = newX;
					item.y = newY;
					previousX = item.x;
					previousY = item.y;
					previousW = item.width;
					previousH = item.height;			
				}
			}
			if (row.length > 0) {
				//trace("item despues de breakline");
				_rows.push(row);
			}
		}
		
		/* INTERFACE net.absulit.arbolnegro.interfaces.Destroy */
		
		public function destroy():void {
			_width = NaN;
			_height = NaN;
			_rows = null;
		}
		
		override public function get width():Number {
			return super.width;
		}
		/**
		 * Resize the container
		 */
		override public function set width(value:Number):void {
			//super.width = value;
			_width = value;
		}
		
		override public function get height():Number {
			return super.height;
		}
		
		override public function set height(value:Number):void {
			_height = value;
		}
		
		
	}

}