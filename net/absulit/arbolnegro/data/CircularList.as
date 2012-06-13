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

package net.absulit.arbolnegro.data {
	import net.absulit.arbolnegro.interfaces.Destroy;
	/**
	 * Extendeds the Array Class with paging functions and other new methods
	 * @author Sebastián Sanabria Díaz
	 */
	public dynamic class CircularList extends Array implements Destroy{
		private var _item:*;
		private var _page:Array;
		private var _pages:Array;
		private var _numPages:uint;
		private var _numPageItems:uint;
		
		private var _itemIndex:int;
		private var _pageIndex:int;
		
		/**
		 * Constructor
		 */
		public function CircularList() {
			super();
			init();
		}
		
		private function init():void {
			_item = null;
			_page = null;
			_pages = null;
			_numPages = 0;
			_numPageItems = 0;
			_itemIndex = 0;
			_pageIndex = 0;
			
		}
		
		/**
		 * The current item defined by itemIndex
		 */
		public function get item():* { return  this[_itemIndex]; }
		
		public function set item(value:*):void {
			this[_itemIndex] = _item = value;
		}
		
		/**
		 * The current page defined by pageIndex
		 */
		public function get page():Array { 
			_page = new Array();
			var initIndex:uint = _pageIndex * _numPageItems;
			var finalIndex:uint = initIndex + _numPageItems
			for (var k:uint = initIndex; k <  finalIndex ; k++ ) {
				_page.push(this[k])
			}
			return _page;	
		}
		
		public function set page(value:Array):void {
			//TODO: sizes must match
			_page = value;
		}
		/**
		 * Array with pages (each page with items)
		 */
		public function get pages():Array { return _pages; }
		
		public function set pages(value:Array):void {
			_pages = value;
		}
		/**
		 * The number of pages stablished by the user
		 */
		public function get numPages():uint { return _numPages; }
		
		public function set numPages(value:uint):void {
			_numPages = value;
			//TODO: arreglar esto
			_numPageItems = value;
			_numPages = this.length / _numPageItems;
			if (this.length % _numPageItems != 0){
				_numPages++;
			}
		}
		/**
		 * The number of items per page stablished by the user
		 */
		public function get numPageItems():uint { return _numPageItems; }
		
		public function set numPageItems(value:uint):void {
			_numPageItems = value;
			_numPages = this.length / _numPageItems;
			if (this.length % _numPageItems != 0){
				_numPages++;
			}
		}
		/**
		 * Current item index that can be lower from zero, or greater than length;
		 * the index is self-correcting
		 */
		public function get itemIndex():int { return _itemIndex; }
		
		public function set itemIndex(value:int):void {
			_itemIndex = value;
			//TODO:cambiar por _itemIndex = _itemIndex % this.length
			if (_itemIndex > this.length - 1) {
				while (_itemIndex > this.length - 1) {
					_itemIndex -= this.length;
				}
			}else if(_itemIndex < 0){
				while (_itemIndex < 0 && _itemIndex < this.length) {
					_itemIndex += this.length;
				}
			}			
			//_item = this[_itemIndex];			
		}
		/**
		 * Current page index
		 */
		public function get pageIndex():int { return _pageIndex; }

		public function set pageIndex(value:int):void {
			_pageIndex = value;
			
			if (_pageIndex > _numPages - 1) {
				while (_pageIndex > _numPages- 1) {
					_pageIndex -= _numPages;
				}
			}else if(_pageIndex < 0){
				while (_pageIndex < 0 && _pageIndex < _numPages) {
					_pageIndex += _numPages;
				}
			}
			
			itemIndex = _pageIndex * _numPageItems;
		}
		
		/**
		 * The next item and updates itemIndex
		 * @return the item in the next position
		 */
		public function next():*{
			++itemIndex;
			return this[_itemIndex];
		}
		/**
		 * The previous item and updates itemIndex
		 * @return the item in the previous position
		 */
		public function previous():*{
			--itemIndex;
			return this[_itemIndex];
		}
		
		/**
		 * Return the firs item
		 * @return the item in the first position
		 */
		public function first():*{
			return this[0];
		}
		
		/**
		 * Returns the last item in CircularList
		 * @return the iten in the last position
		 */
		public function last():*{
			return this[this.length - 1];
		}
		
		/**
		 * Returns the index of param value
		 * @param	value item to find index
		 * @return -1 if not exists or the index of value
		 */
		public function indexOfItem(value:*):int {
			var item:*;
			var index:int = -1;
			for (var k:uint = 0; k < this.length; k++) {
				item = this[k];
				if (item == value) {
					index = k;
					break;
				}
			}
			return index;
		}
		
		public function hasItem(value:*):Boolean {
			var exists:Boolean = false;
			for each (var item:* in this) 
			{
				if (item == value) {
					exists = true;
					break;
				}
			}
			return exists;
		}
		
		/* INTERFACE net.absulit.arbolnegro.interfaces.Destroy */
		
		public function destroy():void {
			_item = null;
			_page = null;
			_pages = null;
			_numPages = NaN;
			_numPageItems = NaN;
			_itemIndex = NaN;
			_pageIndex = NaN;
		}
	}

}