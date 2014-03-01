package  
{
	 import flash.events.Event;
	
	public class ObjectEvent extends Event
	{
		
		private var _data:Object = null;
		public function ObjectEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_data = data;            
		}
		public function get data():Object {
		  return _data;        
		}
		public function set data(value:Object):void {
		  _data = value;
		
		}
		
	}
	
}