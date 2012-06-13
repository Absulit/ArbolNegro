  /**
	ArbolNegro - actionscript3 multipurpose code
    Copyright (C) 2010  Sebastián Sanabria Díaz - arbolnegro.absulit.net - arbolnegroaAS3@gmail.com - admin@absulit.net

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

package net.absulit.arbolnegro.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class ConsoleEvent extends Event {
		public static const ENTER:String = "enter";
		protected var _args:Array;
		protected var _line:String;
		public function ConsoleEvent(type:String, args:Array, line:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			_args = args;
			_line = line;
			super(type, bubbles, cancelable);
			
		}
		
		override public function clone():Event {
			var consoleEvent:ConsoleEvent = new ConsoleEvent(this.type, _args, _line, this.bubbles, this.cancelable);
			return consoleEvent;
		}
		
		public function get args():Array{
			return _args;
		}
		
		public function get line():String {
			return _line;
		}
		
		public override function toString():String { 
			return formatToString("ConsoleEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}

}