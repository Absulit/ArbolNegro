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

package net.absulit.arbolnegro.interfaces
{
	import com.hexagonstar.util.debug.Debug;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Sebastián Sanabria Díaz
	 */
	public class Greybox extends Sprite
	{
		public static const CLOSED:String = "closed";
		private var _content:MovieClip
		private var _color:uint = 0x333333;
		private var _alpha:Number = .75;
		private var _tweenA:Tween;
		private var _holder:Sprite;
		private var _screen:Sprite;
		public function Greybox() 
		{
			super();
			//this.visible = false;
			_screen = new Sprite();
			//_screen.graphics.lineStyle(0,_color,_alpha);
			_screen.graphics.beginFill(_color,_alpha);
			_screen.graphics.drawRect(0,0,800,600);
			_screen.graphics.endFill();
			_screen.addEventListener(MouseEvent.CLICK, onClickScreen);
			addChild(_screen);
			_holder = new Sprite();
			addChild(_holder);
		}
		
		private function onClickScreen(e:MouseEvent):void 
		{
			close();
		}
		
		public function open():void {
			//visible = true;
			_tweenA = new Tween(this, "alpha", Strong.easeOut, 0, 1, 1, true);
			//_tweenA.addEventListener(TweenEvent.MOTION_FINISH,onMotionFinishTweenA)
		}
		
		public function close():void {
			_tweenA = new Tween(this, "alpha", Strong.easeOut, 1, 0, 1, true);
			_tweenA.addEventListener(TweenEvent.MOTION_FINISH,onMotionFinishTweenA)
		}
		
		private function onMotionFinishTweenA(e:Event):void 
		{
			visible = false;
			dispatchEvent(new Event(CLOSED));
		}
		
		public function get content():MovieClip { return _content; }
		
		public function set content(value:MovieClip):void 
		{
			_content = value;
			_screen.width = _content.stage.stageWidth;
			_screen.height = _content.stage.stageHeight;
			Debug.trace( _content.stage.stageWidth+" " +_content.stage.stageHeight);
			_content.x = (_content.stage.stageWidth - _content.width) >> 1;
			_content.y = (_content.stage.stageHeight - _content.height) >> 1;
			while (_holder.numChildren > 0) {
				_holder.removeChildAt(0);
			}
			_holder.addChild(_content);
		}
		
	}

}