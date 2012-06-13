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

package net.absulit.arbolnegro.layouts
{
	import fl.transitions.easing.Strong;
	import fl.transitions.Tween;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Sebastián Sanabria Díaz
	 */
	public class LiquidLayoutObject {
		private var _target:DisplayObject;
		private var _alignment:String;
		private var _delay:Number;
		private var _stage:Stage;
		//private var _originalX:Number;
		//private var _originalY:Number;
		private var _ratioX:Number;
		private var _ratioY:Number;
		private var _tweenX:Tween;
		private var _tweenY:Tween;
		public function LiquidLayoutObject(target:DisplayObject, align:String = "null", delay:Number = 2) {
			_target = target;
			_alignment = align;
			_delay = delay;
			_stage = _target.stage;

			if (_stage != null) {
				init();
			}else {
				_stage.addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			_stage.removeEventListener(Event.ADDED_TO_STAGE, init);

			if (_stage.scaleMode != StageScaleMode.NO_SCALE) {
				_stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			if (_stage.align != StageAlign.TOP_LEFT) {
				_stage.align = StageAlign.TOP_LEFT;
			}
			_ratioX = _target.x / _stage.stageWidth;
			_ratioY = _target.y / _stage.stageHeight;
			assignAlign();
			
		}
		
		private function onActivate(e:Event):void {
			align();
		}
		
		private function onResize(e:Event):void {
			align();
		}
		
		private function onDeactivate(e:Event):void {
			align();
		}
		
		public function align():void {
			switch (_alignment)	{
				case LiquidLayoutAlign.TOP:				top(); break;
				case LiquidLayoutAlign.BOTTOM:			bottom(); break;
				case LiquidLayoutAlign.RIGHT:			right(); break;
				case LiquidLayoutAlign.LEFT:			left(); break;
				case LiquidLayoutAlign.CENTER:			center(); break;
				case LiquidLayoutAlign.TOP_CENTER:		topCenter(); break;
				case LiquidLayoutAlign.BOTTOM_CENTER:	bottomCenter(); break;
				case LiquidLayoutAlign.TOP_RIGHT:		topRight(); break;
				case LiquidLayoutAlign.TOP_LEFT:		topLeft(); break;
				case LiquidLayoutAlign.BOTTOM_RIGHT:	bottomRight(); break;
				case LiquidLayoutAlign.BOTTOM_LEFT:		bottomLeft(); break;
				case LiquidLayoutAlign.FLOAT:			float(); break;
				case LiquidLayoutAlign.VERTICAL:		vertical(); break;
				case LiquidLayoutAlign.HORIZONTAL:		horizontal(); break;
				case LiquidLayoutAlign.NONE:			none(); break;
					
				//default:
			}

		}
		
		private function top():void {
			_tweenY = new Tween(_target, "y", Strong.easeOut, _target.y, 0, _delay, true);
		}
		
		private function bottom():void {
			_tweenY = new Tween(_target, "y", Strong.easeOut, _target.y, _stage.stageHeight - _target.height, _delay, true);
		}
		
		private function right():void {
			_tweenX = new Tween(_target, "x", Strong.easeOut, _target.x, _stage.stageWidth - _target.width, _delay, true);

		}
		
		private function left():void {
			_tweenX = new Tween(_target, "x", Strong.easeOut, _target.x, 0, _delay, true);
		}
		
		private function center():void {
			vertical(); horizontal();
		}
		
		private function topCenter():void {
			center();
			top();
		}
		
		private function bottomCenter():void {
			center();
			bottom();
		}
		
		private function topRight():void {
			top(); right();
		}
		
		private function topLeft():void{
			top(); left();
		}
		
		private function bottomRight():void {
			bottom(); right();
		}
		
		private function bottomLeft():void {
			bottom(); left();
		}
		
		private function float():void {
			_tweenX = new Tween(_target, "x", Strong.easeOut, _target.x, (_ratioX * _stage.stageWidth), _delay, true);
			_tweenY = new Tween(_target, "y", Strong.easeOut, _target.y, (_ratioY * _stage.stageHeight), _delay, true);
		}
		
		private function vertical():void {
			var pY:Number = (_stage.stageHeight - _target.height)/2
			_tweenY = new Tween(_target, "y", Strong.easeOut, _target.y, pY, _delay, true);
		}
		
		private function horizontal():void {
			var pX:Number = (_stage.stageWidth - _target.width) / 2
			_tweenX = new Tween(_target, "x", Strong.easeOut, _target.x, pX, _delay, true);
		}
		
		private function none():void {
			
		}
		
		private function assignAlign():void {
			/*try {
				_stage.removeEventListener(Event.ACTIVATE, onActivate);
				_stage.removeEventListener(Event.RESIZE, onResize);
				_stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
			}catch (err:Error){

			}*/
			if (_alignment != LiquidLayoutAlign.NONE) {
				_stage.addEventListener(Event.ACTIVATE, onActivate);
				_stage.addEventListener(Event.RESIZE, onResize);
				_stage.addEventListener(Event.DEACTIVATE, onDeactivate);
				align();
			}
		}
		
		public function get target():DisplayObject {
			return _target;
		}
		
		public function set target(value:DisplayObject):void {
			_target = value;
		}
		/**
		 * Defined by LiquidLayoutAlign constants
		 */
		public function get alignment():String {
			return _alignment;
		}
		
		public function set alignment(value:String):void {
			_alignment = value;
		}
		
		public function get delay():Number {
			return _delay;
		}
		
		public function set delay(value:Number):void {
			_delay = value;
		}
		

		
	}

}