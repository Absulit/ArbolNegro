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
	import net.absulit.arbolnegro.data.CircularList;
	import net.absulit.arbolnegro.interfaces.Container;
	import net.absulit.arbolnegro.interfaces.ContainerScaleStates;
	/**
	 * ...
	 * @author Sebastián Sanabria Díaz
	 */
	public class RotatorContained extends Sprite {
		private var _rotator:Rotator;
		private var _container:Container;
		
		public function RotatorContained() {
			super();
			init()
		}
		
		private function init():void {
			_rotator = new Rotator();
			_rotator.addEventListener(Event.COMPLETE, onCompleteRotator);
			_container = new Container();
			_container.content = _rotator;
			//_container.scroll = true;
			
			addChild(_rotator);
		}
		
		private function onCompleteRotator(e:Event):void{
			//_container.width = width;
			//_container.height = height;
			_container.scaleState = ContainerScaleStates.AUTO;
			dispatchEvent(e);
		}
		
		public function get path():String
		{
			return _rotator.path;
		}
		
		public function set path(value:String):void
		{
			_rotator.path = value;
		}
		
		public function get paths():CircularList
		{
			return _rotator.paths;
		}
		
		public function set paths(value:CircularList):void
		{
			_rotator.paths = value;
		}
		
		public function start():void {
			_rotator.start();
		}
		
		public function stop():void {
			_rotator.stop();
		}
		
		override public function get width():Number{
			return _container.width;
		}
		
		
		override public function set width(value:Number):void{
			_container.width = value;
			_container.scaleState = ContainerScaleStates.AUTO;
		}
		
		override public function get height():Number{
			return _container.height;
		}
		
		override public function set height(value:Number):void{
			_container.height = value;
			_container.scaleState = ContainerScaleStates.AUTO;
		}
		
		public function get rotator():Rotator {
			return _rotator;
		}
		
		public function destroy():void {
			if (_rotator.hasEventListener(Event.COMPLETE)) { _rotator.removeEventListener(Event.COMPLETE, onCompleteRotator) }
			_rotator.destroy();
			_rotator = null;
			_container = null;
		}
		
		
	}

}