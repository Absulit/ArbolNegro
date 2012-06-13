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
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.absulit.arbolnegro.data.CircularList;
	import net.absulit.arbolnegro.events.SimpleTransitionEvent;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class Rotator extends SimpleTransition 
	{
		private var _timer:Timer;
		private var _seconds:uint = 7;
		private var _paths:CircularList;
		public function Rotator() 
		{
			super();
			//after here the images must be loaded
		}
		/**
		 * Starts the transitions
		 */
		public function start():void {
			if (_paths == null) {
				throw new Error("Property 'paths' must be initialized before to call start()");
			}
			this.path = _paths.first();
			_timer = new Timer(_seconds * 1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			
		}
		
		override protected function onAllTransitionInDone(e:Event):void 
		{
			//trace("onAllTransitionInDone");
			_timer.start();
			super.onAllTransitionInDone(e);
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_timer.stop();
			this.path = _paths.next();
		}
		
		public function stop():void {
			_timer.stop();
		}
		
		public function get paths():CircularList 
		{
			return _paths;
		}
		
		public function set paths(value:CircularList):void 
		{
			_paths = value;
		}
		

		
	}

}