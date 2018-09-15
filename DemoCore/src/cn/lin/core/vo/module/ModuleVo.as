package cn.lin.core.vo.module
{
	import cn.lin.core.interFace.IVo;
	
	public class ModuleVo implements IVo
	{
		public var name:String;
		public var params:Object;
		public function ModuleVo($name:String, $params:Object)
		{
			this.name = $name;
			params = $params;
		}
		
		public function parseXml(xml:XML):void
		{
		}
	}
}