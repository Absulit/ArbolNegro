  /**
	ArbolNegro - actionscript3 multipurpose code
    Copyright (C) 2013  Sebastián Sanabria Díaz - arbolnegro.absulit.net - arbolnegroaAS3@gmail.com - admin@absulit.net

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
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * To handle easy writing of txt files
	 * @author Sebastian Sanabria Diaz
	 * 2013
	 */
	public class TextFile {
		private var _path:String;
		private var _file:File;
		private var _fileStream: FileStream;
		private var _isOpen:Boolean;
		public function TextFile(path:String) {
			_path = path;
			init();
		}
		
		/**
		 * 
		 */
		private function init():void {
			_file = new File(_path);
			_fileStream = new FileStream();
			_fileStream.open(_file, FileMode.UPDATE);
			_isOpen = true;
		}
		
		/**
		 * Write at the end of the file without adding an EOL
		 * @param	value Text to save
		 */
		public function write(value:String):void {
			// TODO: position:Number = null agregar parametro para introducir texto en posicion
			if (!_isOpen) {
				init();
			}
			_fileStream.position = _fileStream.bytesAvailable;
			_fileStream.writeMultiByte(value, File.systemCharset);
		}
		
		/**
		 * Write at the end of the file with an EOL
		 * @param	value
		 */
		public function writeln(value:String):void {
			if (!_isOpen) {
				init();
			}
			_fileStream.writeMultiByte(value + "\n\r", File.systemCharset);
		}
		
		/**
		 * Current file path
		 */
		public function get path():String {
			return _path;
		}
		
		/**
		 * Close the file you are using
		 */
		public function close():void {
			_fileStream.close();
			_isOpen = false;
		}
		
		/**
		 * Reads one line from the current position
		 * @return the line read or null if file does not exists
		 */
		public function readln():String {
			var char:String;
			var line:String;
			if (_isOpen) {
				line = "";
				while(_fileStream.position < _fileStream.bytesAvailable){
					char = _fileStream.readUTFBytes(1);
					if(char == "\n"){
						break;
					}else{
						line.concat(char);
					}
				}
			}
			return line;			
		}
		
		/**
		 * Remove or delete file
		 */
		public function remove():void {
			if (_isOpen) {
				_fileStream.close();
				_isOpen = false;
			}
			_file.deleteFile();
		}
		
	}

}