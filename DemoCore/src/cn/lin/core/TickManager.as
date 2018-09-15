package cn.lin.core
{
	import flash.utils.getTimer;
	
	import cn.lin.core.interFace.ITick;

	public class TickManager
	{
		private static var _instance:TickManager;
		private var _tickList:Vector.<ITick>;
		
		public function TickManager(clz:InnerClz)
		{
			if(_instance || !clz){
				throw new Error("this is single instance");
			}
			_tickList = new Vector.<ITick>();
		}
		
		public static function get instance():TickManager
		{
			if(!_instance){
				_instance = new TickManager(new InnerClz());
			}
			return _instance;
		}
		
		public function addTick(tick:ITick):void
		{
			if(tick && _tickList.indexOf(tick) == -1){
				_tickList.push(tick);
			}
		}
		
		public function removeTick(tick:ITick):void
		{
			var index:int = _tickList.indexOf(tick);
			if(index != -1){
				_tickList.slice(index, 1);
			}
		}
		
		private static var _step:int = getTimer();
		public function render():void
		{
			var time:int = getTimer();
			var len:int = _tickList.length;
			for(var i:int = 0;i < len;i ++){
				var tick:ITick = _tickList[i];
				tick.update(time - _step);
			}
			_step = time;
		}
	}
}

internal class InnerClz{}