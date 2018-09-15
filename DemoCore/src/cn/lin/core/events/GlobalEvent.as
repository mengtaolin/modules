package cn.lin.core.events
{
	import flash.events.Event;
	
	public class GlobalEvent extends Event
	{
		public static const CLOSE_MODULE:String = "close_module";
		
		public var data:Object;
		public function GlobalEvent(type:String, $data:Object = null)
		{
			super(type);
			data = $data;
		}
	}
}