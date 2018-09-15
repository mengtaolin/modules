package cn.lin.core.gameLoader.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import cn.lin.core.GlobalParams;
	import cn.lin.core.gameLoader.LoadTimer;
	import cn.lin.core.gameLoader.vo.LoadVo;
	import cn.lin.core.interFace.ILoader;
	import cn.lin.core.interFace.IModule;
	
	/**
	 * 二进制文件加载器
	 * @author 林孟涛
	 * 
	 */
	public class SwfLoader extends Loader implements ILoader
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
		private var _context:LoaderContext;
		
		public function SwfLoader(loadCompleteFunc:Function, loadProgressFunc:Function, loadErrorFunc:Function)
		{
			super();
			_loadCompleteFunc = loadCompleteFunc;
			_loadProgressFunc = loadProgressFunc;
			_loadErrorFunc = loadErrorFunc;
			_context = new LoaderContext(true, ApplicationDomain.currentDomain, null);
		}
		
		public function set loadVo($loadVo:LoadVo):void
		{
			if(this._vo == $loadVo || $loadVo == null){
				return;
			}
			this._vo = $loadVo;
			this.load(new URLRequest(_vo.url));
		}
		
		public function get loadVo():LoadVo
		{
			return _vo;
		}
		
		override public function load($request:URLRequest, $context:LoaderContext=null):void
		{
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			this.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			
			super.load($request, _context);
			LoadTimer.instance.addTime(url, close, null);
		}
		
		
		/**
		 * 加载完成
		 * @param event
		 */
		protected function onComplete(event:Event):void
		{
			GlobalParams.addModule(url, this.content as IModule);
			if(_loadCompleteFunc){
				_loadCompleteFunc(url, _vo.type);
			}
			if(_vo && _vo.callBack){
				_vo.callBack(_vo.url, this.content as IModule);
			}
			clearFunc();
			this.removeEvents();
			this._vo = null;
		}
		
		private function clearFunc():void
		{
			_loadCompleteFunc = null;
			_loadProgressFunc = null;
			_loadErrorFunc = null;
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
			if(_loadErrorFunc){
				_loadErrorFunc(event);
			}
			this._vo = null;
		}
		
		private function removeEvents():void
		{
			this.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			this.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
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
			return loadLv <= _loadLv && isLoading == false && loadType == type;
		}
		
	}
}