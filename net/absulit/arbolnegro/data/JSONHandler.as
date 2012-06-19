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

package net.absulit.arbolnegro.data {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import net.absulit.arbolnegro.interfaces.Destroy;
	
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class JSONHandler extends EventDispatcher implements Destroy {
		private var _path:String;
		private var _urlLoader:URLLoader;
		private var _json:Object;
		public function JSONHandler() {
			init();
		}
		

		
		private function init():void {
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.INIT, onInitEvent);
			_urlLoader.addEventListener(Event.COMPLETE, onCompleteURLLoader)
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgressURLLoader)
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatusEventURLLoader);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onInitEvent(e:Event):void {
			dispatchEvent(e);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			dispatchEvent(e);
		}
		
		private function onIOError(e:IOErrorEvent):void {
			dispatchEvent(e);
		}
		
		private function onHTTPStatusEventURLLoader(e:HTTPStatusEvent):void {
			dispatchEvent(e);
		}
		
		private function onProgressURLLoader(e:ProgressEvent):void {
			dispatchEvent(e);
		}
		
		private function onCompleteURLLoader(e:Event):void {
			_json = JSON.parse(_urlLoader.data);
			dispatchEvent(e);
		}
		
		public function get path():String {
			return _path;
		}
		
		public function set path(value:String):void {
			_path = value;
			_urlLoader.load(new URLRequest(_path));
		}
		
		public function get json():Object {
			return _json;
		}
		
		/* INTERFACE net.absulit.arbolnegro.interfaces.Destroy */
		
		public function destroy():void {
			_urlLoader.removeEventListener(Event.INIT, onInitEvent);
			_urlLoader.removeEventListener(Event.COMPLETE, onCompleteURLLoader)
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressURLLoader)
			_urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatusEventURLLoader);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_urlLoader = null;
			_path = null;
			_json = null;
		}
		
	}

}