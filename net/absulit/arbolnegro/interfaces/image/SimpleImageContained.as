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

package net.absulit.arbolnegro.interfaces.image {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.absulit.arbolnegro.events.SimpleImageContainedEvent;
	import net.absulit.arbolnegro.interfaces.Container;
	import net.absulit.arbolnegro.interfaces.ContainerScaleStates;
	import net.absulit.arbolnegro.interfaces.Destroy;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class SimpleImageContained extends SimpleImage implements Destroy{
		private var _container:Container;
		private var _mask:Sprite;
		private var _borderLine:Sprite;
		private var _border:Boolean;
		public function SimpleImageContained() {
			super();
			init();
		}
		
		private function init():void {			
			_container = new Container();
			_container.scaleState = ContainerScaleStates.AUTO
			_container.width = 80;
			_container.height = _container.width;
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, _container.width, _container.height);
			_mask.graphics.endFill();
			_border = false;	
		}
		
		override protected function onCompleteContentLoaderInfo(e:Event):void {	
			e.target.removeEventListener(Event.COMPLETE, onCompleteContentLoaderInfo);
			super.onCompleteContentLoaderInfo(e);
			_container.content = this._content;
			//_container.content = this._loader.content;
			_container.centerH = true;
			_container.centerV = true;
			_container.drag = true;
			_container.content.addEventListener(MouseEvent.CLICK, onClickContent);
			addChildAt(_mask,0);
			_container.content.mask = _mask;
			if (_borderLine != null) {
				addChildAt(_borderLine,0);	
			}
			dispatchEvent(new SimpleImageContainedEvent(SimpleImageContainedEvent.COMPLETE_CONTAINER));
		}
		
		private function onClickContent(e:MouseEvent):void {
			trace("onClickContent");
		}
		
		override public function get width():Number {
			return _container.width;
		}
		
		override public function set width(value:Number):void {
			//super.width = value;
			_container.width = value;
			if(_borderLine != null){
				_borderLine.graphics.clear();
				_borderLine.graphics.lineStyle(2, 0xff0000,.5,true);
				_borderLine.graphics.drawRect(0, 0, _container.width, _container.height);
			}
			
			_mask.width = _container.width;
			_mask.height = _container.height;
		}
		
		override public function get height():Number {
			return _container.height;
		}
		
		override public function set height(value:Number):void {
			//super.height = value;
			_container.height = value;
			if(_borderLine != null){
				_borderLine.graphics.clear();
				_borderLine.graphics.lineStyle(2, 0xff0000,.5,true);
				_borderLine.graphics.drawRect(0, 0, _container.width, _container.height);
			}
			
			_mask.width = _container.width;
			_mask.height = _container.height;
		}
		
		public function get border():Boolean {
			return _border;
		}
		
		public function set border(value:Boolean):void {
			_border = value;
			
			if (_border) {
				_borderLine = new Sprite();
				_borderLine.graphics.lineStyle(2, 0xff0000,.5,true);
				_borderLine.graphics.drawRect(0, 0, _container.width, _container.height);
				addChildAt(_borderLine,0);
			}else if (_borderLine != null) {
				removeChild(_borderLine);
				_borderLine = null;				
			}
		}
		
		public function get container():Container {
			return _container;
		}
		
		override public function destroy():void {
			super.destroy();
			
			if (_container != null) {
				_container.destroy();
				_container = null;
			}	
			if (_mask != null) {
				removeChild(_mask);
				_mask = null;
			}			
			if (_borderLine != null) {
				removeChild(_borderLine);
				_borderLine = null;				
			}			
			_border = false;
		}
	}

}