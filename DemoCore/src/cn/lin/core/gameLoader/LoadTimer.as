package cn.lin.core.gameLoader
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import cn.lin.core.TickManager;
	import cn.lin.core.gameLoader.vo.TimeVo;
	import cn.lin.core.interFace.ITick;

	public class LoadTimer implements ITick
	{
		private static var _instance:LoadTimer;
		/**
		 * 60秒为一分钟
		 */
		private static const TIME:int = 60000
		/**
		 * 60帧为一秒，每秒看下有没有超时的
		 */
		private static const TICK:int = 60;
		/**
		 * 加载队列，保存TimeVo对象
		 */
		private var _loadDic:Dictionary = new Dictionary();
		/**
		 * 帧计算器
		 */
		private var _count:int = 0;
		
		
		public function LoadTimer(innerClz:InnerClz)
		{
			if(_instance || innerClz == null){
				throw new Error("This is Single instance");
			}
			TickManager.instance.addTick(_instance);
		}
		
		public static function get instance():LoadTimer
		{
			if(!_instance){
				_instance = new LoadTimer(new InnerClz());
			}
			return _instance;
		}
		
		public function addTime(url:String, callBack:Function, callBackParam:Object):TimeVo
		{
			var vo:TimeVo;
			if(_loadDic.hasOwnProperty(url) && _loadDic[url]){
				vo = _loadDic[url]
				return vo;
			}
			vo = new TimeVo();
			vo.url = url;
			vo.callBack = callBack;
			vo.tick = 0;
			vo.callBackParam = callBackParam;
			vo.time = getTimer();
			_loadDic[vo.url] = vo;
			return vo;
		}
		
		public function removeTime(url:String):void
		{
			if(_loadDic.hasOwnProperty(url)){
				var vo:TimeVo = _loadDic[url];
				vo.clear();
				delete _loadDic[url];
				vo = null;
			}
		}
		
		public function update(time:int):void
		{
			_count ++;
			if(_count >= 60){//分帧做法
				_count = 0;
				for(var url:String in _loadDic){
					var vo:TimeVo = _loadDic[url];
					if(vo.check(TIME)){
						vo.doCallBack();
						delete _loadDic[url];
					}
				}
			}
		}
		
		
	}
}

internal class InnerClz{}