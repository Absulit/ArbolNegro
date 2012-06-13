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


package net.absulit.arbolnegro.data 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.system.ApplicationDomain;
	import flash.text.TextFormat;
	import flash.text.Font;
	import net.absulit.arbolnegro.interfaces.image.SimpleImage;
	/**
	 * Loads font from SWF to be applied to a TextField
	 * @author Sebastián Sanabria Díaz
	 */
	public class ExternalFont extends SimpleImage
	{
		public static const APPLIED_BEFORE:String = "applied_before";
		public static const APPLIED_AFTER:String = "applied_after";
		private var _textFormat:TextFormat;
		public function ExternalFont() 
		{
			super();			
		}
		/**
		 * Aplies a Font to a TextField
		 * @param	fontName Font Class name inside the .swf file
		 * @param	textField TextField to apply Font
		 * @param	timeToApply The actual moment when you use the setFont function, 'after' or 'before' the text is applied to .text property in textField
		 */
		public function setFont(fontClassName:String, textField:TextField, timeToApply:String = APPLIED_BEFORE) {		
			if (!_loadComplete) {
				throw new Error("setFont must be called after Event.COMPLETE");
			}
			var C:Class = _loader.contentLoaderInfo.applicationDomain.getDefinition(fontClassName) as Class;
			var font:Font = new C();
			Font.registerFont(C);
			var textFormat:TextFormat = new TextFormat(font.fontName);
			if (timeToApply == APPLIED_AFTER) {
				textField.defaultTextFormat = textFormat;					
			}else
			if (timeToApply == APPLIED_BEFORE) {
				textField.setTextFormat(textFormat);
			}
			else {
				throw new Error("timeToApply parameter must be ExternalFont.APPLIED_AFTER or ExternalFont.APPLIED_BEFORE, not '" + timeToApply + "'");
			}				
			textField.embedFonts = true;
		}
		
		/**
		 * Textformat produced as the result of using the function setFont()
		 */
		public function get textFormat():TextFormat { return _textFormat; }
	}

}
