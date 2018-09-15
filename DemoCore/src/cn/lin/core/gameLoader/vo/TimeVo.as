package cn.lin.core.gameLoader.vo
{
	import flash.utils.getTimer;

	public class TimeVo
	{
		public function TimeVo()
		{
		}
		
		public var callBack:Function;
		public var callBackParam:Object;
		public var url:String;
		public var time:int;
		public var tick:int = 0;
		
		public function check(limitTime:int):Boolean
		{
			var curTime:int = getTimer();
			if(curTime - this.time > limitTime){
				return true;
			}
			return false;
		}
		
		public function doCallBack():void
		{
			if(callBack){
				if(callBackParam){
					callBack.apply(null, [callBackParam]);
				}
				else{
					callBack();
				}
			}
		}
		
		public function clear():void
		{
			callBack = null;
			callBackParam = null;
			url = null;
		}
	}
}