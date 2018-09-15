package cn.lin.core.gameLoader.vo
{
	/**
	 * 加载VO
	 * @author 林孟涛
	 * 
	 */
	public class LoadVo
	{
		public function LoadVo($url:String, $level:int, $callBack:Function, $type:int, $callBackData:Object)
		{
			url = $url;
			level = $level;
			callBack = $callBack;
			type = $type;
			callBackData = $callBackData
		}
		
		/**
		 * 等待加载的地址，当加载模块的时候，这个就是module name
		 */
		public var url:String;
		/**
		 * 等待加载的等级
		 */
		public var level:int;
		
		/**
		 * 回调函数
		 */
		public var callBack:Function;
		
		/**
		 * 加载文件的类型
		 */
		public var type:int;
		/**
		 * 加载成功后传入的参数
		 */
		public var callBackData:Object;
	}
}