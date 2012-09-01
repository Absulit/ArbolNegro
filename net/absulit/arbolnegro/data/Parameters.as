package net.absulit.arbolnegro.data {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
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
	public class Parameters extends EventDispatcher implements Destroy{
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		private var _vars:URLVariables;
		private var _data:Object;
		private var _url:String;
		private var _HTTPStatus:int;
		public function Parameters(url:String) {
			_url = url;
			init();
		}
		
		private function init():void {
			_urlLoader = new URLLoader();
			//_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(Event.INIT, onInitEvent);
			_urlLoader.addEventListener(Event.COMPLETE, onCompleteURLLoader)
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgressURLLoader)
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatusEventURLLoader);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			_urlRequest = new URLRequest(_url);
			_urlRequest.method = URLRequestMethod.GET;
			
			_vars = new URLVariables();
			_urlRequest.data = _vars;
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
			_HTTPStatus = e.status;
			dispatchEvent(e);
		}
		
		private function onProgressURLLoader(e:ProgressEvent):void {
			dispatchEvent(e);
		}
		
		private function onCompleteURLLoader(e:Event):void {
			_data = _urlLoader.data;
			dispatchEvent(e);
		}
		
		public function get vars():URLVariables {
			return _vars;
		}
		
		public function set vars(value:URLVariables):void {
			_vars = value;
			_urlRequest.data = _vars;
		}
		
		public function get method():String {
			return _urlRequest.method;
		}
		
		public function set method(value:String):void {
			_urlRequest.method = value;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function get HTTPStatus():int {
			return _HTTPStatus;
		}
		/**
		 * Array of URLRequestHeader
		 */
		public function get headers():Array {
			return _urlRequest.requestHeaders;
		}
		
		public function set headers(value:Array):void {
			_urlRequest.requestHeaders = value
		}
		
		public function load():void {
			_urlLoader.load(_urlRequest);
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
			_url = null;
			_data = null;
			
			_urlRequest = null;
			_vars = null;
		}
	}

}