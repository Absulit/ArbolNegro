package net.absulit.arbolnegro.data {
	import flash.system.Capabilities;
	/**
	 * Handles pixel convertion between screens devices
	 * @author Sebastian Sanabria Diaz
	 */
	public class DPIManager {
		private static var _instance:DPIManager;
		private var _baseDPI:Number;
		private var _ratio:Number
		public function DPIManager(pvt:SingletonEnforcer) {
			init();
		}
		
		private function init():void {
			_baseDPI = 72;
			_ratio = _baseDPI / Capabilities.screenDPI;
			trace("Current DPI", Capabilities.screenDPI);
		}
		
		public static function get instance():DPIManager {
			if ( _instance == null ) {
				_instance = new DPIManager( new SingletonEnforcer() );
			}
			return _instance;
		}
		
		public function get baseDPI():Number {
			return _baseDPI;
		}
		
		public function set baseDPI(value:Number):void {
			_baseDPI = value;
			_ratio = _baseDPI / Capabilities.screenDPI;
		}
		
		public function ratio(value:Number):Number {
			return value / _ratio;
		}
		
		public function recalibratePxls(value:Number):Number {
			return inToPxls( pxlsToIn(value) );
		}
		
		public function pxlsToIn(value:Number):Number {
			return (value / _baseDPI)
		}
		
		public function inToPxls(value:Number):Number {	
			return Capabilities.screenDPI * value;
		}
		
		public function cmToPxls(value:Number):Number {
			return Capabilities.screenDPI * (value * 0.3937);
		}
	}

}

internal class SingletonEnforcer{}