package cn.lin.core.interFace
{
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	
	import cn.lin.core.vo.module.ModuleUpdateVo;
	import cn.lin.core.vo.module.ModuleVo;
	

	public interface IModule extends IEventDispatcher, IBitmapDrawable
	{
		/**
		 * 模块初始化
		 */
		function init():void;
		function get name():String;
		/**
		 * 模块启动方法
		 * @param args
		 */
		function startup(moduleVo:ModuleVo):void;
		function get moduleVo():ModuleVo;
		function update(vo:ModuleUpdateVo):void;
		/**
		 * 移除模块
		 */
		function dispose():void;
	}
}