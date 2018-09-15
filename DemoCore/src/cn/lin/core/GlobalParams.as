package cn.lin.core
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import cn.lin.core.interFace.IModule;

	public class GlobalParams
	{
		public static var game_width:int;
		public static var game_height:int;
		
		public static var _resizeList:Array = [];
		
		private static var _modulesDic:Dictionary = new Dictionary();
		private static var _filesDic:Dictionary = new Dictionary();
		
		public static function addModule(url:String, module:IModule):void
		{
			if(_modulesDic.hasOwnProperty(url) == false || _modulesDic[url] == null){
				_modulesDic[url] = module;
			}
		}
		
		public static function getModule(url:String):IModule
		{
			if(_modulesDic.hasOwnProperty(url)){
				return _modulesDic[url] as IModule;
			}
			return null;
		}
		
		public static function removeModule(url:String):void
		{
			if(_modulesDic.hasOwnProperty(url)){
				delete _modulesDic[url];
			}
		}
		
		public static function addFile(url:String, file:Object):void
		{
			if(_filesDic.hasOwnProperty(url) == false || _filesDic[url] == null){
				_filesDic[url] = file;
			}
		}
		
		public static function getFile(url:String):Object
		{
			if(_filesDic.hasOwnProperty(url) && _filesDic[url] != null){
				return _filesDic[url];
			}
			return null;
		}
		
		public static function removeFile(url:String):void
		{
			if(_filesDic.hasOwnProperty(url)){
				delete _filesDic[url];
			}
		}
		
		/**
		 * 添加一个resize函数
		 * @param resize
		 * 
		 */
		public static function addResize(resize:Function):void
		{
			if(_resizeList.indexOf(resize) == -1){
				_resizeList.push(resize);
			}
		}
		
		/**
		 * 移除一个resize函数
		 * @param resize
		 */
		public static function removeResize(resize:Function):void
		{
			var index:int = _resizeList.indexOf(resize);
			if(_resizeList.indexOf(resize) != -1){
				_resizeList.splice(index, 1);
			}
		}
		
		/**
		 * 全局resize事件执行函数
		 * @param event
		 */
		public static function onResize(event:Event):void
		{
			var len:int = _resizeList.length;
			for(var i:int = 0;i < len;i ++){
				var resize:Function = _resizeList[i];
				if(resize){
					resize(event);
				}
			}
		}
	}
}