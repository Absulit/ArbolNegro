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

package net.absulit.arbolnegro.internet{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	/**
	 * This class provides network info
	 * Keep in mind
	 * 	<uses-permission android:name="android.permission.INTERNET" />
		<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
		<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
	 * @author Sebastián Sanabria Díaz
	 */
	public class InternetConnection extends EventDispatcher {
		private static var _instance:InternetConnection;
		public static const WIFI:String = "wifi";
		public static const MOBILE:String = "mobile";
		private static var _type:String = null;
		private static var _available:Boolean;
		public static function get instance():InternetConnection {
			if ( _instance == null ) {
				_instance = new InternetConnection( new SingletonEnforcer() );
			}
			return _instance;
		}
		
		public function get type():String {
			return _type;
		}
		
		static public function get available():Boolean {
			return _available;
		}
 
		public function InternetConnection( pvt:SingletonEnforcer ) {
			// init class
			NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, onNetworkChange);
		}
		
		public function checkConnection():void {
			var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			var conCounter:uint = 0;
			for (var i:uint = 0; i < interfaces.length; i++) {
				if(interfaces[i].name.toLowerCase() == WIFI && interfaces[i].active) {
					_type = WIFI;
					++conCounter;
					break;
				} else if(interfaces[i].name.toLowerCase() == MOBILE && interfaces[i].active) {
					_type = MOBILE;
					++conCounter;
					break;
				}			
			}			
			_available = conCounter != 0;
			dispatchEvent(new Event(Event.NETWORK_CHANGE));
		}
		
		private function onNetworkChange(e:Event = null):void {
			checkConnection();
		}
	}
}
 
internal class SingletonEnforcer{}