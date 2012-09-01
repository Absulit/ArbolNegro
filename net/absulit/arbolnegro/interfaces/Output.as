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

package net.absulit.arbolnegro.interfaces {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Creates a TextField all over the swf to print stuff. 
	 * Primarily intended for debugging.
	 * @author Sebastian Sanabria Diaz
	 */
	
	public class Output extends TextField {
		public function Output() {
			super();
			this.multiline = true;
			this.background = true;
			this.backgroundColor = 0x000000;
			this.defaultTextFormat = new TextFormat("Courier New", 12, 0xFFD203, true);
			if (stage != null){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
		/**
		 * Writes an object with an EOL
		 * @param	value an object to be printed
		 */
		public function wl(...rest):void {
			//appendText('> ' + line + '\n');
			var value:String;
			for each (var item:Object in rest) {
				value += String(item) + " ";
			}
			
			this.htmlText += ' ' + value+ '<br/>';
			this.scrollV = this.maxScrollV;
			setSelection(text.length,text.length);
		}
		
		/**
		 * Writes an object without an EOL
		 * @param	value
		 */
		public function w(value:Object):void {
			this.htmlText += ' ' + value.toString();
			this.scrollV = this.maxScrollV;
			setSelection(text.length,text.length);
		}
	}

}