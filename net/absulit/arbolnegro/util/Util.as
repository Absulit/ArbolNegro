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
	
package net.absulit.arbolnegro.util 
{
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.StageDisplayState;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class Util
	{
		
		public function Util() 
		{
			throw new Error("You can not instantiate Util Class");
		}
		
		/**
		 * Gets a variables through FlashVars from HTML.
		 * @param	stage Current Stage
		 * @param	flashVarName Variable name.
		 * @param	defaultValue The default value if the variable is undefined
		 * @return  Current value of flashVarName of defaultValue.
		 */
		public static function getFlashVar(stage:DisplayObject,flashVarName:String, defaultValue:String = ""):String {
			var paramObj:Object = LoaderInfo(stage.root.loaderInfo).parameters;
			var value:String = String(paramObj[flashVarName]);
			if (value.toString() == "undefined") {
				value = defaultValue;
			}
			return value;
		}
		
		/**
		 * Establece que el swf actual se vea en modo de pantalla completa.
		 * @param	stage <code>Stage</code> en contexto actual.
		 * @return  Valor <code>Boolean</code> que representa el estado actual de pantalla completa.
		 */
		public static function toggleFullScreen(stage:Stage):Boolean{
			var isFullScreen:Boolean = false;
			if (stage.displayState != StageDisplayState.FULL_SCREEN) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				isFullScreen = true;
			} else {
				stage.displayState = StageDisplayState.NORMAL;
			}
			return isFullScreen;
		}
		
		public static function getURL(url:String, target:String = "_self"):void {
			var request:URLRequest = new URLRequest(url);
			try {
				navigateToURL(request, target);// second argument is target
			} catch (e:Error) {
				throw new Error("Error while trying to access " + url);
			}
		}
		
		
	}

}