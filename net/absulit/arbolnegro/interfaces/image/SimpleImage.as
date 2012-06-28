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

package net.absulit.arbolnegro.interfaces.image {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import net.absulit.arbolnegro.interfaces.Destroy; 
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="init", type="flash.events.Event")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="ioError", type = "flash.events.IOErrorEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	/**
	 * Loads image files and swf
	 * @author Sebastián Sanabria Díaz
	 */
	public dynamic class SimpleImage extends MovieClip implements Destroy {
		private var _path:String;
		private var _smooth:Boolean;
		protected var _loader:Loader;
		protected var _content:DisplayObject;
		protected var _loadComplete:Boolean;
		public function SimpleImage() {
			super();
			init();
		}
		
		private function init():void {
			_path = "";
			_smooth = false;
			_loadComplete = false;
		}
		/**
		 * The URL from the file to load
		 */
		public function get path():String { return _path; }

		public function set path(value:String):void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			_path = value;
			_loadComplete = false;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteContentLoaderInfo);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onInitContentLoaderInfo);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressContentLoaderInfo);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorContentLoaderInfo);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpenContentLoaderInfo);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorContentLoaderInfo);
			_loader.load(new URLRequest(_path));
		}
		
		private function onSecurityErrorContentLoaderInfo(e:SecurityErrorEvent):void {
			//security listener is removed at onCompleteContentLoaderInfo
			dispatchEvent(e);
		}
		
		private function onOpenContentLoaderInfo(e:Event):void {
			e.target.removeEventListener(Event.OPEN, onOpenContentLoaderInfo);
			dispatchEvent(e);
		}
		
		private function onIOErrorContentLoaderInfo(e:Event):void {
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorContentLoaderInfo);
			dispatchEvent(e);
		}
		
		private function onProgressContentLoaderInfo(e:ProgressEvent):void {
			//progress listener is removed at onCompleteContentLoaderInfo
			dispatchEvent(e);
		}
		
		private function onInitContentLoaderInfo(e:Event):void {
			e.target.removeEventListener(Event.INIT, onInitContentLoaderInfo);
			dispatchEvent(e);
		}
		
		protected function onCompleteContentLoaderInfo(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onCompleteContentLoaderInfo);
			e.target.removeEventListener(ProgressEvent.PROGRESS, onProgressContentLoaderInfo);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorContentLoaderInfo);
			_content = _loader.content;
			if (_path.indexOf(".swf") == -1) {
				Bitmap(_content).smoothing = _smooth;
			}
			addChild(_content);
			//addChild(_loader);
			//_loader = null;
			_loadComplete = true;
			dispatchEvent(e);
		}
		
		public function get smooth():Boolean { return _smooth; }
		
		public function set smooth(value:Boolean):void {
			_smooth = value;
			if (_loadComplete) {
				if (_path.indexOf(".swf") == -1) {
					Bitmap(_content).smoothing = _smooth;
				}
			}
		}
		
		public function get content():DisplayObject { return _content; }
		
		
		public function destroy():void {
			/*if(_loader.contentLoaderInfo.hasEventListener(Event.COMPLETE)){_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteContentLoaderInfo)};
			if(_loader.contentLoaderInfo.hasEventListener(Event.INIT)){_loader.contentLoaderInfo.removeEventListener(Event.INIT, onInitContentLoaderInfo)};
			if(_loader.contentLoaderInfo.hasEventListener(ProgressEvent.PROGRESS)){_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressContentLoaderInfo)};
			if(_loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR)){_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorContentLoaderInfo)};
			if(_loader.contentLoaderInfo.hasEventListener(Event.OPEN)){_loader.contentLoaderInfo.removeEventListener(Event.OPEN, onOpenContentLoaderInfo)};
			if(_loader.contentLoaderInfo.hasEventListener(SecurityErrorEvent.SECURITY_ERROR)){_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorContentLoaderInfo)};
			*/
			_loader = null;
			_path = null;
			_content = null;
		}
	}

}