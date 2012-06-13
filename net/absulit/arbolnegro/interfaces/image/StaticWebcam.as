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
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.absulit.arbolnegro.events.SimpleTransitionEvent;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class StaticWebcam extends TransitionContained {
		private var _timer:Timer;
		private var _seconds:uint;
		public function StaticWebcam(path:String, seconds:Number) {
			super();
			this.path = path;
			_seconds = seconds;
			init();
		}
		
		private function init():void{
			addEventListener(SimpleTransitionEvent.TRANSITION_FINISHED, onTranstionFinished);
			_timer = new Timer(_seconds * 1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTranstionFinished(e:SimpleTransitionEvent):void {
			_timer.start();
		}
		
		private function onTimer(e:TimerEvent):void {
			_timer.stop();
			this.path = this.path;
		}
		
		public function start():void {
			_timer.start();
		}
		
		public function stop():void {
			_timer.stop();
		}
		
		public function get seconds():uint {
			return _seconds;
		}
		
		public function set seconds(value:uint):void {
			_seconds = value;
			_timer = new Timer(_seconds * 1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		override public function destroy():void {
			super.destroy();
			removeEventListener(SimpleTransitionEvent.TRANSITION_FINISHED, onTranstionFinished);
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer = null;
			//_seconds = null;
		}
		
	}

}