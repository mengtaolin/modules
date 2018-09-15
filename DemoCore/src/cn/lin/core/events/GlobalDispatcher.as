package cn.lin.core.events
{
	import flash.events.EventDispatcher;
	
	[Event(name="close_module", type="cn.lin.core.events.GlobalEvent")]
	public class GlobalDispatcher extends EventDispatcher
	{
		private static var _instance:GlobalDispatcher;
		
		public function GlobalDispatcher(clz:InnerClz)
		{
			super();
			if(_instance || !clz){
				throw new Error("This is single instance");//这样确保单例只能通过 get instance()方法调用
			}
		}
		
		public static function get instance():GlobalDispatcher
		{
			if(!_instance){
				_instance = new GlobalDispatcher(new InnerClz);
			}
			return _instance;
		}
	}
}

internal class InnerClz{}