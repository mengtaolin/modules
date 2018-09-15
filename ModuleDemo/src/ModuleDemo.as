package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import cn.lin.core.events.MainModuleEvent;
	import cn.lin.core.gameLoader.LoaderController;
	import cn.lin.core.interFace.IModule;
	import cn.lin.core.vo.module.ModuleUpdateVo;
	import cn.lin.core.vo.module.ModuleVo;
	
	import fl.controls.Button;
	
	public class ModuleDemo extends Sprite implements IModule
	{
		private var _name:String = "ModuleDemo";
		private var _moduleVo:ModuleVo;
		private var _moduleDic:Dictionary;
		private var _btn:Button;
		
		public function ModuleDemo()
		{
			super();
			this.init();
		}
		/**
		 * 模块初始化
		 */
		public function init():void
		{
			_moduleDic = new Dictionary();
			this.initView();
		}
		
		private function initView():void
		{
			_btn = new Button();
			_btn.x = _btn.y = 30;
			_btn.label = "加载新内容";
			this.addChild(_btn);
			_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var url:String = "Module1.swf";
			if(_moduleDic.hasOwnProperty(url) && _moduleDic[url] && _moduleDic[url] is IModule){
				loadComplete(url, _moduleDic[url], {});
			}
			else
			{
				LoaderController.instance.load(url, loadComplete, {});
			}
		}
		
		private function loadComplete(url:String, module:IModule, params:Object = null):void
		{
			var moduleName:String = module.name;
			if(_moduleDic.hasOwnProperty(moduleName) == false || _moduleDic[moduleName] == null || !(_moduleDic[moduleName] is IModule)){
				_moduleDic[moduleName] = module;
			}
			module.addEventListener(MainModuleEvent.MODULE_INIT, onModuleInit);
			module.addEventListener(MainModuleEvent.MODULE_CLOSE, onModuleClose, false);
			this.addChild(module as DisplayObject);
			trace("loadComplete == ", module.name);
			var domain:ApplicationDomain = ApplicationDomain.currentDomain;
			trace(domain);
		}
		public function update(vo:ModuleUpdateVo):void
		{
			
		}
		/**
		 * 模块初始化完成
		 * @param event
		 */
		private function onModuleInit(event:MainModuleEvent):void
		{
			
		}
		
		private function onModuleClose(event:MainModuleEvent):void
		{
			var module:IModule = event.currentTarget as IModule;
			module.dispose();
			module.removeEventListener(MainModuleEvent.MODULE_CLOSE, onModuleClose);
			module.removeEventListener(MainModuleEvent.MODULE_INIT, onModuleInit);
			delete _moduleDic[module.name];
			LoaderController.instance.deleteLoadedUrl(module.name);
			if(module && this.contains(module as DisplayObject)){
				this.removeChild(module as DisplayObject);
			}
			module = null;
		}
		
		override public function get name():String
		{
			return this._name;
		}
		/**
		 * 模块启动方法
		 * @param args
		 */
		public function startup(moduleVo:ModuleVo):void
		{
			this._moduleVo = moduleVo;
		}
		
		public function get moduleVo():ModuleVo
		{
			return this._moduleVo;
		}
		/**
		 * 移除模块
		 */
		public function dispose():void
		{
			
		}
		
	}
}