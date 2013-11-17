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
		}
		
		/**
		 * Write at the end of the file without adding an EOL
		 * @param	value Text to save
		 */
		public function write(value:String):void {
			// TODO: position:Number = null agregar parametro para introducir texto en posicion
			_fileStream.position = _fileStream.bytesAvailable;
			_fileStream.writeMultiByte(value, File.systemCharset);
		}
		
		/**
		 * Write at the end of the file with an EOL
		 * @param	value
		 */
		public function writeln(value:String):void {
			_fileStream.writeMultiByte(value + "\r\n", File.systemCharset);
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
		}
		
		/**
		 * Reads one line from the current position
		 * @return the line read
		 */
		public function readln():String {
			var char:String;
			var line:String = "";			
			while(_fileStream.position < _fileStream.bytesAvailable){
				char = _fileStream.readUTFBytes(1);
				if(char == "\n"){
					break;
				}else{
					line.concat(char);
				}
			}
			return line;			
		}
		
	}

}