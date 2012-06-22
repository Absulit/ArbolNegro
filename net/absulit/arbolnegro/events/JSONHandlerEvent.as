package net.absulit.arbolnegro.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class JSONHandlerEvent extends Event {
		public static const INVALID_JSON_INPUT:String = "invalidJSONInput";
		public function JSONHandlerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new JSONHandlerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("JSONHandlerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}