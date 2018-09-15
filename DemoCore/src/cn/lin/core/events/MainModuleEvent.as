package cn.lin.core.events
{
	import flash.events.Event;
	
	public class MainModuleEvent extends Event
	{
		/**
		 * 模块初始化完成   Module_init
		 */
		public static const MODULE_INIT:String = "Module_init";
		/**
		 * 模块关闭    Module_close
		 */
		public static const MODULE_CLOSE:String = "Module_close";
		/**
		 * 模块更新    Module_Update
		 */
		public static const MODULE_UPDATE:String = "Module_Update";
		
		public function MainModuleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}