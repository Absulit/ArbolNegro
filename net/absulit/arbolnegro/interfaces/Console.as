  /**
	ArbolNegro - actionscript3 multipurpose code
    Copyright (C) 2011  Sebastián Sanabria Díaz - arbolnegro.absulit.net - arbolnegroaAS3@gmail.com - admin@absulit.net

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

package net.absulit.arbolnegro.interfaces {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import net.absulit.arbolnegro.events.ConsoleEvent;
	
	/**
	 * Mimics the behaviour of a console or terminal window; extends the Output Class.
	 * Dispatches a net.absulit.arbolnegro.events.ConsoleEvent
	 * @author Sebastian Sanabria Diaz
	 */
	
	public class Console extends Output {

		public function Console() {
			super();
			this.type = TextFieldType.INPUT;
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			if (stage != null){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == 13) {
				//var command:String = "";
				//var args:Array = new Array();
					// number of lines showing in myText: 
					var numLines:uint = (this.bottomScrollV - this.scrollV)+1; 
					var totalLines:uint = numLines+ (this.maxScrollV - 1); 
					
					var lastLine:String = this.getLineText(totalLines - 1);
					//trace(lastLine);
					var items:Array =  lastLine.split(" ");
					//trace(items);
					/*command = items[0];
					for (var i:int = 1; i < items.length; i++) 
					{
						args.push(items[i]);
						
					}*/
				this.scrollV = this.maxScrollV;
				dispatchEvent(new ConsoleEvent(ConsoleEvent.ENTER, items, lastLine));
			}
			
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		

		
	}

}