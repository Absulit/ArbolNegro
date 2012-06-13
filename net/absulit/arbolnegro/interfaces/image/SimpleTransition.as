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

package net.absulit.arbolnegro.interfaces.image{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import net.absulit.arbolnegro.events.SimpleTransitionEvent;
	import net.absulit.arbolnegro.events.TransitionEvent;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class SimpleTransition extends Sprite {
		private var _simpleImage1:SimpleImage;
		private var _simpleImage2:SimpleImage;
		private var _path:String;
		private var _smooth:Boolean;
		
		//private var _transitionManager:TransitionManager;
		private var _type:Class = fl.transitions.Fade;
		private var _direction:Number = Transition.IN;
		private var _duration:Number = 1000;
		private var _easing:Function = Strong.easeOut;
		
		public function SimpleTransition() {
			super();
			init();
		}
		
		private function init():void {
			_simpleImage1 = new SimpleImage();
			_simpleImage2 = new SimpleImage();
			_simpleImage1.addEventListener(Event.COMPLETE, onCompleteSimpleImage);
			_simpleImage2.addEventListener(Event.COMPLETE, onCompleteSimpleImage);
			addChild(_simpleImage2)
			addChild(_simpleImage1);
		}
		
		protected function onCompleteSimpleImage(e:Event):void {
			//var mc:MovieClip = MovieClip(e.currentTarget);
			var mc:SimpleImage = SimpleImage(e.currentTarget);
			mc.content.cacheAsBitmap = true;
			var tm:TransitionManager = new TransitionManager(mc);
			tm.addEventListener("allTransitionsInDone", onAllTransitionInDone);
			tm.addEventListener("allTransitionsOutDone", onAllTransitionOutDone);
			tm.startTransition({ type:_type, direction:_direction, duration:(_duration / 1000), easing:_easing } );
			dispatchEvent(e);
		}
		
		/*protected function onMotionFinishTM(e:Event):void 
		{
			dispatchEvent(new SimpleTransitionEvent(SimpleTransitionEvent.TRANSITION_FINISHED, true));
		}*/
		
		protected function onAllTransitionInDone(e:Event):void {
			dispatchEvent(new SimpleTransitionEvent(SimpleTransitionEvent.TRANSITION_FINISHED, true));
		}
		
		private function onAllTransitionOutDone(e:Event):void {
			trace("allTransitionsOutDone");
		}
		
		public function get path():String {
			return _path;
		}
		
		
		
		public function set path(value:String):void {
			_path = value;
			bottomImage().path = _path;
			swapImages();
		}
		
		/**
		 * As defined by fl.transitions.*
		 */
		public function get type():Class {
			return _type;
		}
		
		/**
		 * As defined by fl.transitions.*
		 */
		public function set type(value:Class):void {
			_type = value;
		}
		
		public function get easing():Function {
			return _easing;
		}
		
		public function set easing(value:Function):void {
			_easing = value;
		}
		
		public function get duration():Number {
			return _duration;
		}
		
		public function set duration(value:Number):void {
			_duration = value;
		}
		
		public function get direction():Number 
		{
			return _direction;
		}
		
		public function set direction(value:Number):void {
			_direction = value;
		}
		
		public function get smooth():Boolean {
			return _smooth;
		}
		
		public function set smooth(value:Boolean):void {
			_smooth = value;
			_simpleImage1.smooth = _simpleImage2.smooth = _smooth;
		}
		
		public function get bottomImagePath():String {
			return bottomImage().path;
		}
		
		public function set bottomImagePath(value:String):void {
			bottomImage().path = value;
		}
		
		public function get topImagePath():String {
			return topImage().path;
		}
		
		public function set topImagePath(value:String):void {
			topImage().path = value;
		}
		
		private function swapImages():void {
			addChild(getChildAt(0))
		}
		
		private function topImage():SimpleImage {
			return getChildAt(1) as SimpleImage;
		}
		
		private function bottomImage():SimpleImage {
			return getChildAt(0) as SimpleImage;
		}
		
		public function destroy():void {
			
			_simpleImage1.removeEventListener(Event.COMPLETE, onCompleteSimpleImage);
			_simpleImage2.removeEventListener(Event.COMPLETE, onCompleteSimpleImage);			
			_simpleImage1.destroy();
			_simpleImage2.destroy();
			_simpleImage1 = null;
			_simpleImage2 = null;
			_path = null
			//_smooth = null
			
			//_transitionManager = null
			_type = null
			//_direction = null
			//_duration = null
			_easing = null
		}
		
	}

}