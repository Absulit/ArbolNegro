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

package net.absulit.arbolnegro.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class SimpleImageContainedEvent extends Event {
		public static const COMPLETE_CONTAINER:String = "completeContainer";
		public function SimpleImageContainedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new SimpleImageContainedEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("SimpleImageContainedEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}