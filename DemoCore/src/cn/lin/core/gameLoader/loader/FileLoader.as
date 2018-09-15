package cn.lin.core.gameLoader.loader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import cn.lin.core.GlobalParams;
	import cn.lin.core.gameLoader.LoadTimer;
	import cn.lin.core.gameLoader.vo.LoadVo;
	import cn.lin.core.interFace.ILoader;
	
	/**
	 * 文件加载器
	 * @author 林孟涛
	 * 
	 */
	public class FileLoader extends URLLoader implements ILoader
	{
		/**
		 * 是否正在使用
		 */
		private var _isLoading:Boolean;
		private var _vo:LoadVo;
		/**
		 * 创建出来时根据配置生成的加载器类型
		 */
		private var _loadType:int;
		/**
		 * 创建出来时根据配置生成的加载器优先级
		 */
		private var _loadLv:int;
		/**
		 * 加载控制器的回调LoaderController的加载完成函数
		 */
		private var _loadCompleteFunc:Function;
		/**
		 * 加载控制器的回调LoaderController的加载进度函数
		 */
		private var _loadProgressFunc:Function;
		/**
		 * 加载控制器的回调LoaderController的加载错误函数
		 */
		private var _loadErrorFunc:Function;
		
		public function FileLoader(loadCompleteFunc:Function, loadProgressFunc:Function = null, loadErrorFunc:Function = null)
		{
			super();
			_loadCompleteFunc = loadCompleteFunc;
			_loadProgressFunc = loadProgressFunc;
			_loadErrorFunc = loadErrorFunc;
		}
		
		public function set loadVo($loadVo:LoadVo):void
		{
			this._vo = $loadVo;
			var urlReq:URLRequest = new URLRequest(_vo.url);
			this.load(urlReq);
		}
		
		public function get loadVo():LoadVo
		{
			return _vo;
		}
		
		override public function load($request:URLRequest):void
		{
			this.addEventListener(Event.COMPLETE, onComplete);
			this.addEventListener(ProgressEvent.PROGRESS, onProgress);
			this.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			this._isLoading = true;
			super.load($request);
			LoadTimer.instance.addTime(url, this.close, null);
		}
		protected function onComplete(event:Event):void
		{
			GlobalParams.addFile(_vo.url, event.target.data);
			this._isLoading = false;
			if(_loadCompleteFunc){
				_loadCompleteFunc(event, this._loadType);
			}
			if(_vo.callBack){
				_vo.callBack(event);
			}
			this.removeEvents();
			clearFunc();
		}
		
		private function clearFunc():void
		{
			_loadCompleteFunc = null;
			_loadProgressFunc = null;
			_loadErrorFunc = null;
			this._vo = null;
		}
		
		protected function onProgress(event:ProgressEvent):void
		{
			if(_loadProgressFunc){
				_loadProgressFunc(event);
			}
		}
		
		protected function onIoError(event:IOErrorEvent):void
		{
			this.removeEvents();
			this._isLoading = false;
			if(_loadErrorFunc){
				_loadErrorFunc(_vo.url);
			}
			this._vo = null;
		}
		
		private function removeEvents():void
		{
			this.removeEventListener(Event.COMPLETE, onComplete);
			this.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			this.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			LoadTimer.instance.removeTime(url);
		}
		
		public function get isLoading():Boolean
		{
			return _isLoading;
		}
		
		public function get level():int
		{
			if(_vo){
				return _vo.level;
			}
			return -1;
		}
		
		public function get type():int
		{
			if(_vo){
				return _vo.type;
			}
			return -1;
		}
		
		public function get url():String
		{
			if(_vo){
				return _vo.url;
			}
			return null;
		}
		
		
		public function get loadLv():int
		{
			return _loadLv;
		}
		
		public function set loadLv($loadLv:int):void
		{
			this._loadLv = $loadLv;
		}
		
		public function get loadType():int
		{
			return _loadType;
		}
		
		public function set loadType($loadType:int):void
		{
			this._loadType = $loadType;
		}
		public function canLoad(type:int):Boolean
		{
			return loadLv <= level && isLoading == false && loadType == type;
		}
		
	}
}