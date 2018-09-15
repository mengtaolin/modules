package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import cn.lin.core.events.MainModuleEvent;
	import cn.lin.core.interFace.IModule;
	import cn.lin.core.vo.module.ModuleUpdateVo;
	import cn.lin.core.vo.module.ModuleVo;
	
	import fl.controls.Button;
	import fl.controls.Label;
	
	public class Module1 extends Sprite implements IModule
	{
		private var _name:String = "Module1";
		private var _moduleVo:ModuleVo;
		private var _btn:Button;
		
		public function Module1()
		{
			super();
			x = y = 60;
			this.init();
			this.dispatchEvent(new MainModuleEvent(MainModuleEvent.MODULE_INIT));
		}
		
		/**
		 * 模块初始化
		 */
		public function init():void
		{
			var lable:Label = new Label();
			lable.text = "module1";
			this.addChild(lable);
			_btn = new Button();
			_btn.label = "关闭";
			_btn.y = 30;
			this.addChild(_btn);
			_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.dispatchEvent(new MainModuleEvent(MainModuleEvent.MODULE_CLOSE));
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
		
		public function update(vo:ModuleUpdateVo):void
		{
			
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
			_btn.removeEventListener(MouseEvent.CLICK, onClick);
			var num:int = this.numChildren;
			while(num > 0){
				var child:DisplayObject = this.removeChildAt(0);
				child = null;
				num = this.numChildren;
			}
		}
	}
}