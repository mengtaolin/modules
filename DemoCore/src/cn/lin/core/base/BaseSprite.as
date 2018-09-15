package cn.lin.core.base
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class BaseSprite extends Sprite
	{
		public function BaseSprite()
		{
			super();
			this.init();
		}
		
		protected function init():void{}
		
		protected function initEvents():void{}
		
		protected function removeEvents():void{}
		
		public function show(...args):void{}
		
		public function hide():void{}
		
		public function dispose():void
		{
			this.removeEvents();
			while(this.numChildren > 0){
				var child:DisplayObject = this.removeChildAt(0);
				if(child is BaseSprite){
					BaseSprite(child).dispose();
				}
				child = null;
			}
		}
	}
}