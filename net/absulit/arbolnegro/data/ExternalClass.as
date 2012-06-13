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
	import flash.system.ApplicationDomain;
	import net.absulit.arbolnegro.interfaces.image.SimpleImage;
	/**
	 * Loads Classes pre compiled inside a SWF.
	 * @WARNING 1: It's better if inside is only one precompiled class and not nested;
	 * otherwise any other class must be loaded IN THE PARENT CLASS(The same class that you try to load).
	 * @WARNING 2: The Type of the var tha receive the "new" must be "*" in special cases (a swf that loads another).
	 * @WARNING 3: Loaded classes may not have a stage so you can not detect ADDED_TO_STAGE event.
	 * @author Sebastián Sanabria Díaz
	 */
	public class ExternalClass extends SimpleImage{
		private var _value:Class;
		public function ExternalClass() {
			super();			
		}		
		
		
		
		public function getClass(name:String):Class {
			//return _value = ApplicationDomain.currentDomain.getDefinition(name) as Class;						
			return _value = _loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
		}
		
		/*public function getDocumentClass():DisplayObject {
			return _loader.loaderInfo.content;
		}*/
		
		public function get value():Class { return _value; }
		
	}

}