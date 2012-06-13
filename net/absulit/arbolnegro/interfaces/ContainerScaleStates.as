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

package net.absulit.arbolnegro.interfaces 
{
	/**
	 * ...
	 * @author Sebastián Sanabria Díaz
	 */
	public class ContainerScaleStates
	{
		/**
		 * Default state, restores the original scale of the content
		 */
		public static  const NULL:String = "null";
		/**
		 * This state scales the content to the container's width while preserving the aspect ratio
		 */
		public static  const WIDTH:String = "width";
		/**
		 * This state scales the content to the container's height while preserving the aspect ratio
		 */
		public static  const HEIGHT:String = "height";
		/**
		 * Chooses the lower lenght side, to fit content  to the container 
		 */
		public static  const AUTO:String = "auto";
		/**
		 * Chooses the greater lenght side, to fit content  to the container 
		 */
		public static  const  AUTO_REVERSE:String = "auto_reverse";
		/**
		 * 
		 */
		public function ContainerScaleStates() 
		{
			throw new Error("ContainerStates should not be instantiated");
		}
		
	}

}