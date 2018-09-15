package cn.lin.core.gameLoader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	import cn.lin.core.GlobalParams;
	import cn.lin.core.gameLoader.loader.FileLoader;
	import cn.lin.core.gameLoader.loader.SwfLoader;
	import cn.lin.core.gameLoader.vo.LoadVo;
	import cn.lin.core.interFace.ILoader;
	import cn.lin.core.interFace.IModule;

	/**
	 * 加载控制器
	 * @author 林孟涛
	 * 
	 */
	public class LoaderController
	{
		private var _loaderList:Vector.<ILoader>;
		private var _loader:Loader;
		/**
		 * 
		 */
		private var _url:String;
		/**
		 * 已加载的内容列表
		 */
		private var _loadedDic:Dictionary;
		/**
		 * 正在加载的内容列表
		 */
		private var _loadingDic:Dictionary;
		/**
		 * 等待列表
		 */
		private var _waitingList:Array;
		
		private static var _instance:LoaderController;
		
		public function LoaderController(clz:InnerClz)
		{
			if(_instance || clz == null){
				throw new Error("This is single instance");
			}
			_loaderList = new Vector.<ILoader>();
			_loadingDic = new Dictionary();
			_loadedDic = new Dictionary();
			_waitingList = [];
			
			for(var i:int = 0;i < LoaderConfig.loaderNum;i ++){
				var obj:Object = LoaderConfig["loader" + i];
				var loader:ILoader;
				if(obj.type == 1 || obj.type == 3)
				{
					 loader = new SwfLoader(onComplete, onProgress, onIoError);
				}
				else if(obj.type == 2){
					loader = new FileLoader(onComplete, onProgress, onIoError);
				}
				loader.loadLv = obj.level;
				loader.loadType = obj.type;
				_loaderList.push(loader);
			}
		}
		
		public static function get instance():LoaderController
		{
			if(!_instance){
				_instance = new LoaderController(new InnerClz);
			}
			return _instance;
		}
		
		public function load(url:String, callBack:Function, callBackData:Object = null, level:int = 1, type:int = 1):void
		{
			if(_loadingDic.hasOwnProperty(url) && _loadingDic[url] == true){//避免重复加载
				return;
			}
			if(_loadedDic.hasOwnProperty(url) && _loadedDic[url]){//避免重复加载，发现已经有了，就直接调用
				if(type == 1)
				{
					var module:IModule = GlobalParams.getModule(url);
					callBack(url, module, callBackData);
					return;
				}
				if(type == 2){//加载文件时使用
					var file:Object = GlobalParams.getFile(url);
					callBack(url, file);
				}
				return;
			}
			var vo:LoadVo = new LoadVo(url, level, callBack, type, callBackData);
			var loader:ILoader = this.getLoader(level, type);
			if(!loader){
				var index:int = this.getWaitingIndexByUrl(url);
				if(index == -1){
					_waitingList.push(vo);
					_waitingList.sortOn("level", Array.NUMERIC|Array.DESCENDING);//永远将level值最大的排在第一位
				}
				else{
					replaceWatingCallBackData(index, callBackData);
				}
				return;
			}
			loader.loadVo = vo;
			_loadingDic[url] = true;
		}
		
		private function replaceWatingCallBackData(index:int, callBackData:Object):void
		{
			if(this._waitingList.hasOwnProperty(index)){
				var vo:LoadVo = _waitingList[index];
				vo.callBackData = callBackData;
			}
		}
		
		private function getWaitingIndexByUrl(url:String):int
		{
			var len:int = _waitingList.length;
			for(var i:int = 0;i < len;i ++){
				var vo:LoadVo = _waitingList[i];
				if(vo && vo.url == url){
					return i;
				}
			}
			return -1;
		}
		
		/**
		 * 获取同级别的loader
		 * 等级高的直接去取一个新的loader进行加载，如果统计的loader没有空闲时间则返回空，系统自动加入到等待列表
		 * @param level
		 * @param type
		 * @return 
		 */
		private function getLoader(level:int, type:int):ILoader
		{
			var loader:ILoader = null;
			var len:int = _loaderList.length;
			for(var i:int = 0;i < len;i ++){
				if(_loaderList[i] is SwfLoader){
					var tmpLoader:SwfLoader = _loaderList[i] as SwfLoader;
					if(tmpLoader.canLoad(type)){//
						loader = tmpLoader;
						break;
					}
				}
				else{
					var fileLoader:FileLoader = _loaderList[i] as FileLoader;
					if(fileLoader.canLoad(type)){//
						loader = fileLoader;
						break;
					}
				}
			}
			return loader;
		}
		
		protected function onProgress(event:ProgressEvent):void
		{
			
		}
		
		protected function onIoError(url:String):void
		{
			this.deleteLoadingUrl(url);
			trace("ioError", url);
		}
		
		protected function onComplete(url:String, loadType:int):void
		{
			this.deleteLoadingUrl(url);
			this.addLoaded(url);
			var len:int = _waitingList.length;
			for(var i:int = 0;i < len;i ++){
				var vo:LoadVo = _waitingList[i];
				if(vo.type == loadType){
					_waitingList.splice(i, 1);
					this.load(vo.url, vo.callBack, vo.level, vo.type);
					break;
				}
			}
		}
		
		/**
		 * 
		 * @param url
		 */
		private function addLoaded(url:String):void
		{
			if(_loadedDic.hasOwnProperty(url) == false || !_loadedDic[url]){
				_loadedDic[url] = true
			}
		}
		
		/**
		 * 删除正在下载列表中的内容
		 * @param event
		 */
		private function deleteLoadingUrl(url:String):void
		{
			if(_loadingDic.hasOwnProperty(url)){
				delete _loadingDic[url];
			}
		}
		
		public function deleteLoadedUrl(url:String):void
		{
			url = url + ".swf";
			GlobalParams.removeModule(url);
			if(_loadedDic.hasOwnProperty(url)){
				delete _loadedDic[url];
			}
		}
	}
}

internal class InnerClz{}