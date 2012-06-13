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

package net.absulit.arbolnegro.util 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastián Sanabria Díaz
	 */
	public class MathUtil 
	{
		public static function isBetween(number:Number,minimum:Number, maximum:Number):Boolean {
			return ((maximum <= number) && (number >= minimum));
		}
		
		public static function distance(p1:Object,p2:Object):Number{
			 var dist:Number;
			 var dx:Number; 
			 var dy:Number;
			 dx = p2.x - p1.x;
			 dy = p2.y - p1.y;
			 dist = Math.sqrt(dx * dx + dy * dy);
			 return dist
		}
		public static  function angle(p1:Object,p2:Object):Number {
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			var radians:Number = Math.atan2(dy, dx);
			return degrees(radians)
		}
			
		public static  function degrees(radians:Number):Number {
			return radians * 180 / Math.PI
		}
			
		public static  function radians(degrees:Number):Number {
			return degrees * Math.PI / 180
		}
			
		public static  function vector(distance:Number, angle:Number):Point {
			var rads:Number = radians(angle)
			var newPoint:Point = new Point();
			newPoint = Point.polar(distance, rads);
			return newPoint;
		}
		
		/*public static function normal(x:Number, y:Number, z:Number):Number {
			//*para lo primero, lo q recuerdo es q si tnés 3 puntos en el plano, digamos A, B y C, usas vectores u=AB y v= AC y para encontrar la normal haces N = uxv
			return (z - y)*(x - y);
		}*/		
	}

}