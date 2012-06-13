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
	/**
	 * Classes for converting between certain types of data
	 * @author Sebastian Sanabria Diaz
	 */
	public class Convert
	{
		
		public function Convert() 
		{
			throw new Error("You can not instantiate Convert Class");
		}
		
		/**
		 * Converts a XMLList to Array. Inner data from each element remain intact.
		 * @param	value XMLList to convert
		 * @return Brand new Array
		 */
		public static function XMLListToArray(value:XMLList):Array {
			var arr:Array = new Array();
			for (var k:uint = 0; k < value.length();k++ ) {
				arr.push(value[k]);
			}
			return arr;
		}
		
		/**
		 * Converts a XMLList to CircularList. Inner data from each element remain intact.
		 * @param	value XMLList to convert
		 * @return Brand new CircularList
		 */
		public static function XMLListToCircularList(value:XMLList):CircularList {
			var circularList:CircularList = new CircularList();
			for (var k:uint = 0; k < value.length();k++ ) {
				circularList.push(value[k]);
			}
			return circularList;
		}
		
		/**
		 * Takes a specified attribute from a XMLList node and creates a CircularList
		 * @param	value XMLList to convert to take attributes
		 * @param	attribute Name of the attribute
		 * @return CircularList with all values of that attribute 
		 */
		public static function XMLListAttributeToCircularList(value:XMLList,attribute:String):CircularList {
			var circularList:CircularList = new CircularList();
			
			for (var k:uint = 0; k < value.length();k++ ) {
				circularList.push(value[k].attribute(attribute));
			}
			return circularList;
		}
		
	}

}