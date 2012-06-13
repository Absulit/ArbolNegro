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

package  net.absulit.arbolnegro.interfaces{
	import fl.transitions.easing.*;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import net.absulit.arbolnegro.events.ContainerEvent;
	
	[Event(name="startDrag",type="net.absulit.arbolnegro.events.ContainerEvent")]
	[Event(name="stopDrag",type="net.absulit.arbolnegro.events.ContainerEvent")]
	/**
	 * Creates a virtual container that automatically handles the dynamic and proportional scaling of content, such as SWFs and images
	 * @author Sebastián Sanabria Díaz
	 */
	public class Container extends EventDispatcher implements Destroy {
		protected static const MIN_SPEED:uint = 1;
		protected var _content:DisplayObject;
		protected var _x:Number;
		protected var _y:Number;
		protected var _width:Number;
		protected var _height:Number;
		protected var _tweenX:Tween;
		protected var _tweenY:Tween;
		protected var _scaleState:String;
		protected var _drag:Boolean;
		protected var _scroll:Boolean;
		protected var _centerV:Boolean;
		protected var _centerH:Boolean
		protected var _constraintV:Boolean;
		protected var _constraintH:Boolean;

		protected var _lastMouseP:Point;
		protected var _speed:Point;
		protected var _lastSpeed:Point;
		protected var _friction:Number;
		
		protected var _mouseDown:Boolean;
		protected var _mouseLifted:Boolean;
		protected var _innerW:Boolean;
		protected var _innerH:Boolean;
		
		protected var _originalW:Number;
		protected var _originalH:Number;

		public function Container() {
			init();
		}

		private function init():void {
			_content = null;
			_x = 0;
			_y = 0;
			_width = 0;
			_height = 0;
			_tweenX = null;
			_tweenY = null;
			_scaleState = null;
			_drag = false;
			_scroll = false;
			_mouseDown = false;
			
			_lastMouseP = new Point();
			_speed = new Point();
			_lastSpeed = new Point();
			_mouseLifted = true;
			_friction = .9;
		}
		
		
		public function get scaleState():String { return _scaleState; }
		
		public function set scaleState(value:String):void {
			_scaleState = value;
			if(_content != null){
				if (_scaleState == ContainerScaleStates.AUTO) {
					scaleAuto();
				}else
				if (_scaleState == ContainerScaleStates.WIDTH) {
					scaleWidth();
				}else
				if (_scaleState == ContainerScaleStates.HEIGHT) { 
					scaleHeight();
				}else
				if (_scaleState == ContainerScaleStates.AUTO_REVERSE) {
					scaleAutoReverse() ;
				}else
				if(_scaleState == ContainerScaleStates.NULL) {
					scaleNull();
				}
				
				doCenterH();
				doCenterV();
			}
		}
		
		public function get width():Number { return _width; }
		
		public function set width(value:Number):void {
			_width = value;
			scaleState = _scaleState;
		}
		
		public function get height():Number { return _height; }
		
		public function set height(value:Number):void {
			_height = value;
			scaleState = _scaleState;
		}		
		
		public function get content():DisplayObject { return _content; }
		
		public function set content(value:DisplayObject):void {
			_content = value;			
			_x = value.x;
			_y = value.y;
			_originalW = _content.width;
			_originalH = _content.height;
			scaleState = _scaleState;
		}
		
		public function get x():Number { return _x; }
		
		public function set x(value:Number):void {
			_x = value;
			scaleState = _scaleState;
		}
		
		public function get y():Number { return _y; }
		
		public function set y(value:Number):void {
			_y = value;
			scaleState = _scaleState;
		}
		
		public function get drag():Boolean { return _drag; }
		
		public function set drag(value:Boolean):void {
			_drag = value;	
			if (_drag) {
				if (!_content.hasEventListener(Event.ENTER_FRAME)) {
					_content.addEventListener(Event.ENTER_FRAME, onEnterFrameDrag);

					_content.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownDrag);					
					_content.addEventListener(MouseEvent.MOUSE_UP, onMouseUpDrag);
					_content.addEventListener(MouseEvent.MOUSE_OUT, onMouseUpDrag);
				}
			}else {
				if (_content.hasEventListener(Event.ENTER_FRAME)) {
					_content.removeEventListener(Event.ENTER_FRAME, onEnterFrameDrag);

					_content.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownDrag);					
					_content.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpDrag);
					_content.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUpDrag);
				}
			}	
		}
		
	
		public function get scroll():Boolean { return _scroll; }
		
		public function set scroll(value:Boolean):void {
			_scroll = value;
			if (_scroll) {
				_content.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveScroll);
			}else {
				_content.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveScroll);
			}
		}
		
		public function get centerH():Boolean {
			return _centerH;
		}
		
		public function set centerH(value:Boolean):void {
			_centerH = value;
			if(_content != null){
				doCenterH();
			}
		}
		
		private function doCenterH():void {
			if (_centerH) {
				_content.x = this.x + ((_width - _content.width) / 2);
			}else {
				_content.x = this.x;
			}
		}
		
		public function get centerV():Boolean {
			return _centerV;
		}
		
		public function set centerV(value:Boolean):void {
			_centerV = value;
			if(_content != null){
				doCenterV();
			}
		}
		
		public function get constraintH():Boolean {
			return _constraintH;
		}
		
		public function set constraintH(value:Boolean):void {
			_constraintH = value;
		}
		
		public function get constraintV():Boolean {
			return _constraintV;
		}
		
		public function set constraintV(value:Boolean):void {
			_constraintV = value;
		}
		
		private function doCenterV():void {
			if (_centerV) {
				_content.y = this.y + ((_height - _content.height) / 2);
			}else {
				_content.y = this.y;
			}	
		}
		
		private function onMouseMoveScroll(e:MouseEvent):void {
			//TODO: version simplificada en SelectionStrip
			var enX:Boolean = (_content.parent.mouseX > this._x) && (_content.parent.mouseX < (this._x + this._width));
			var enY:Boolean = (_content.parent.mouseY > this._y) && (_content.parent.mouseY < (this._y + this._height));
			if (enX && enY) {
				var px:Number = (_content.parent.mouseX - this._x) / this._width;
				var py:Number = (_content.parent.mouseY - this._y) / this._height;
				var nx:Number = this._x - (px * ((_content.width - this._width - 1)));
				var ny:Number = this._y - (py * ((_content.height - this._height - 1)));
				///
				_tweenX = new Tween(_content, "x", Strong.easeOut, _content.x, nx, 1, true);
				_tweenY = new Tween(_content, "y", Strong.easeOut, _content.y, ny, 1, true);
			} else {
				
			}
		}
		
		private function getTween(prop:String,begin:Number, end:Number, duration:Number=.1):Tween {
			return new Tween(_content, prop, Regular.easeOut, begin, end, duration, true);
		}
	
		private function onMouseDownDrag(e:Event):void {
			//e.stopPropagation();
			_mouseDown = true;
			
		}

		private function onMouseUpDrag(e:Event):void {
			_mouseDown = false;
			_mouseLifted = true;
			/****************************/

			/****************************/
			dispatchEvent(new ContainerEvent(ContainerEvent.STOP_DRAG));
		}
		
		private function onEnterFrameDrag(e:Event):void {
			var enX:Boolean = (_content.parent.mouseX > this._x) && (_content.parent.mouseX  < (this._x + this._width));
			var enY:Boolean = (_content.parent.mouseY > this._y) && (_content.parent.mouseY < (this._y + this._height));
			if (!(enY && enX)) {
				Mouse.cursor = MouseCursor.ARROW;
			} else{ 
				Mouse.cursor = MouseCursor.HAND;
				if (_mouseDown) {
					var _mouseP:Point = new Point(_content.parent.mouseX, _content.parent.mouseY);
					
					
					var ml:Boolean = false;
					if (_mouseLifted) {
						_mouseLifted = false;
						_lastMouseP.x = _mouseP.x;
						_lastMouseP.y = _mouseP.y;
						ml = true;
					}
					
					_speed.x = _mouseP.x - _lastMouseP.x;
					_speed.y = _mouseP.y - _lastMouseP.y;
					
					//trace(_lastSpeed);
					//trace(_speed);
					
					if ((_speed.x == 0) && !ml) {
						_speed.x = _lastSpeed.x;
					}
					if ((_speed.y == 0) && !ml) {
						_speed.y = _lastSpeed.y;
					}
					
					if(allowMovement()){
						_content.x += _speed.x;
						_content.y += _speed.y;
						
						if (_constraintH) {
							if ((_content.x < _x) || (_content.x > _x)) {
								_content.x = _x;
							}
						}
						if (_constraintV) {
							if ((_content.y < _y) || (_content.y > _y)) {
								_content.y = _y;
							}
						}
						
						dispatchEvent(new ContainerEvent(ContainerEvent.START_DRAG));
					}
					

					
					


					
					
					//
					_lastMouseP.x = _mouseP.x;
					_lastMouseP.y = _mouseP.y;
					
					_lastSpeed.x = _speed.x;
					_lastSpeed.y = _speed.y;
				}else {
	
				}
				
			}
			if (!_mouseDown) {
					_speed.x *= _friction;
					_speed.y *= _friction;
					var ts:Number = .3;
					if (_content.width >= _width) {
						if (  (_content.x > this._x) ) {
							//_tweenX = new Tween(_content, "x", Strong.easeOut, _content.x, this._x, 1, true);
							if (!_innerW) {
								//trace("_innerW");
								_speed.x *= -1;
								_innerW = true;
								//_tweenX = new Tween(_content, "x", Regular.easeInOut, _content.x, this._x, ts, true);
								_tweenX = getTween("x", _content.x, _x, ts);
								_tweenX.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishTweenXInnerW);
							}
							
						}
						if (   ((_content.x + _content.width) < (this._x + this._width))   ) {
							//_tweenX = new Tween(_content, "x", Strong.easeOut, _content.x, _x - (_content.width - this._width), 1, true);
							if (!_innerW) {
								//trace("_innerW");
								_speed.x *= -1;
								_innerW = true;
								//_tweenX = new Tween(_content, "x", Regular.easeInOut, _content.x, _x - (_content.width - this._width), ts, true);
								_tweenX = getTween("x", _content.x, _x - (_content.width - _width), ts);
								_tweenX.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishTweenXInnerW);
							}
							
						}
					}
					//trace("_content.height > _height",_content.height > _height,_content.height , _height);
					if(_content.height >= _height){
						if (_content.y > this._y) {
							//_tweenY = new Tween(_content, "y", Strong.easeOut, _content.y, this._y, 1, true);
							if (!_innerH) {
								//trace("_innerH");
								_speed.y *= -1;
								_innerH = true;
								//_tweenY = new Tween(_content, "y", Regular.easeInOut, _content.y, this._y, .1, true);
								_tweenY = getTween("y", _content.y, _y, ts);
								_tweenY.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishTweenYInnerH);
							}
						}
						if ((_content.y + _content.height) < (this._y + this._height)) {
							//_tweenY = new Tween(_content, "y", Strong.easeOut, _content.y, _y - (_content.height - this._height), 1, true);
							if (!_innerH) {
								//trace("_innerH");
								_speed.y *= -1;
								_innerH = true;
								//_tweenY = new Tween(_content, "y", Regular.easeInOut, _content.y, _y - (_content.height - this._height), ts, true);
								_tweenY = getTween("y", _content.y,  _y - (_content.height - _height), ts);
								_tweenY.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishTweenYInnerH);
							}
						}					
					}
					if(/*!_innerW &&*/  !_constraintH){
						_content.x += _speed.x;
					}
					if(/*!_innerH &&*/ !_constraintV){
						_content.y += _speed.y;	
					}
			}
		}
		
		private function allowMovement():Boolean {			
			return ((_speed.x > MIN_SPEED) || (_speed.y > MIN_SPEED) || (_speed.x < -MIN_SPEED) || (_speed.y < -MIN_SPEED)  );
		}
		
		private function onMotionFinishTweenYInnerH(e:TweenEvent):void {
			_innerH = false;
		}
		
		private function onMotionFinishTweenXInnerW(e:TweenEvent):void {
			_innerW = false;
		}
	
		private function scaleWidth():void {
			var ratio:Number = _content.width/_width
			_content.width /= ratio;
			_content.height /= ratio;		
		}
		
		private function scaleHeight():void {
			var ratio:Number = _content.height / _height
			_content.width /= ratio;
			_content.height /= ratio;
		}
		
		private function scaleAuto():void {
			var containerRatio:Number = _width / _height;
			var contentRatio:Number = _content.width / _content.height
			var ratio:Number = containerRatio / contentRatio;
			if (ratio > 1) {
				scaleWidth();
			}else {
				scaleHeight();
			}
		}
		
		private function scaleAutoReverse():void {
			var containerRatio:Number = _width / _height;
			var contentRatio:Number = _content.width / _content.height
			var ratio:Number = containerRatio / contentRatio;
			if (ratio > 1) {
				scaleHeight();				
			}else {
				scaleWidth();
			}
		}
		
		private function scaleNull():void {
			_content.width = _originalW;
			_content.height = _originalH;
		}
		
		/* INTERFACE net.absulit.arbolnegro.interfaces.Destroy */
		
		public function destroy():void {
			//_content.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveDrag);
			_content.removeEventListener(MouseEvent.MOUSE_UP,onMouseUpDrag);
			_content.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownDrag);
			_content.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUpDrag);
			_content.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveScroll);
			_content.removeEventListener(Event.ENTER_FRAME, onEnterFrameDrag);
			_content = null;
			
			_x = _y = _width = _height = NaN;
			_tweenX = _tweenY = null;
			_scaleState = null;
			_drag = _scroll = _centerV = _centerH = false;

			_mouseDown = false;
			
			
			
			_lastMouseP = null;
			_speed = null;
			_lastSpeed = null;
			_mouseLifted = false;
			_friction = NaN;
		}
		
	}

}