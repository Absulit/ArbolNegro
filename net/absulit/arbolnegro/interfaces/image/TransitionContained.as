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

package net.absulit.arbolnegro.interfaces.image
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.absulit.arbolnegro.interfaces.Container;
	import net.absulit.arbolnegro.interfaces.ContainerScaleStates;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class TransitionContained extends Sprite {
		private var _simpleTransition:SimpleTransition;
		private var _container:Container;
		public function TransitionContained() {
			super();
			init();
		}
		
		private function init():void {
			_simpleTransition = new SimpleTransition();
			_simpleTransition.addEventListener(Event.COMPLETE, onCompleteSimpleTransition);
			_container = new Container();
			_container.content = _simpleTransition;
			_container.scroll = true;
			
			addChild(_simpleTransition);
		}
		

		
		private function onCompleteSimpleTransition(e:Event):void {
			//_container.width = width;
			//_container.height = height;
			_container.scaleState = ContainerScaleStates.AUTO;
			dispatchEvent(e);
		}
		
		public function get path():String {
			return _simpleTransition.path;
		}
		
		public function set path(value:String):void {
			_simpleTransition.path = value;
		}
		
		override public function get width():Number{
			return _container.width;
		}
		
		override public function set width(value:Number):void {
			_container.width = value;
			_container.scaleState = ContainerScaleStates.AUTO;
		}
		
		override public function get height():Number{
			return _container.height;
		}
		
		override public function set height(value:Number):void {
			_container.height = value;
			_container.scaleState = ContainerScaleStates.AUTO;
		}
		
		public function get simpleTransition():SimpleTransition {
			return _simpleTransition;
		}
		
		public function get container():Container {
			return _container;
		}
		
		public function destroy():void {
			if (_simpleTransition.hasEventListener(Event.COMPLETE)) { _simpleTransition.removeEventListener(Event.COMPLETE, onCompleteSimpleTransition) }
			_simpleTransition.destroy();
			_simpleTransition = null;
			_container = null;
		}
	}

}