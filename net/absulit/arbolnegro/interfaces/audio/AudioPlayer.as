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

package net.absulit.arbolnegro.interfaces.audio
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import net.absulit.arbolnegro.data.CircularList;
	/**
	 * ...
	 * @author Sebastián Sanabria Díaz
	 */
	public class AudioPlayer extends EventDispatcher
	{
		private var _trackList:CircularList;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		private var _volume:Number;
		public function AudioPlayer(trackList:CircularList)
		{
			_trackList = trackList;
			init();
		}
		
		private function init():void
		{
			_sound = null;
			_soundChannel = new SoundChannel();
		}
		
		public function get trackList():CircularList { return _trackList; }
		
		public function set trackList(value:CircularList):void
		{
			_trackList = value;
		}
		
		public function get volume():Number { return _volume; }
		
		public function set volume(value:Number):void
		{
			_volume = value;
			if (_soundChannel != null) {
				_soundChannel.soundTransform.volume = _volume;
			}
			
		}
		
		public function play():void {
			_sound = new Sound(new URLRequest(_trackList.item));
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorSound);
			_sound.addEventListener(Event.ID3, onID3Sound);
			_soundChannel = _sound.play();
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteSound);
			_soundChannel.soundTransform.volume = _volume;
		}
		
		private function onID3Sound(e:Event):void {
			dispatchEvent(e);
		}
		
		public function playAt(index:int):void {
			_sound = new Sound(new URLRequest(_trackList[index]));
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorSound);
			_soundChannel = _sound.play();
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteSound);
			_soundChannel.soundTransform.volume = _volume;
			
		}
		
		private function onIOErrorSound(e:IOErrorEvent):void{
			dispatchEvent(e);
		}
		
		private function onCompleteSound(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onCompleteSound);
			next()
			dispatchEvent(e);
		}
		
		public function stop():void {
			_soundChannel.stop();
		}
		
		public function pause():void {
			_soundChannel.stop();
		}
		
		public function previous():void {
			_trackList.previous();
		}
		public function previousAndPlay():void {
			_soundChannel.stop();
			_sound = new Sound(new URLRequest(_trackList.previous() ));
			_soundChannel = _sound.play();
			
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteSound)
		}
		
		public function next():void {
			_trackList.next();
		}
		public function nextAndPlay():void {
			_soundChannel.stop();
			_sound = new Sound(new URLRequest(_trackList.next()));
			_soundChannel = _sound.play();
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteSound)
		}
		
		public function stopAllSounds():void {
			SoundMixer.stopAll();
		}
		
		public function get id3():ID3Info {
			return _sound.id3;
		}
	}

}