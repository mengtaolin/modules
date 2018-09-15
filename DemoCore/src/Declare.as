package
{
	import cn.lin.core.GlobalParams;
	import cn.lin.core.TickManager;
	import cn.lin.core.base.BaseSprite;
	import cn.lin.core.events.GlobalDispatcher;
	import cn.lin.core.events.GlobalEvent;
	import cn.lin.core.interFace.ILoader;
	import cn.lin.core.interFace.IModule;
	import cn.lin.core.interFace.ITest;
	import cn.lin.core.interFace.IVo;

	/**
	 * 确保该类被编译进项目
	 * @author linmengtao
	 */
	public class Declare
	{
		public function Declare()
		{
			GlobalDispatcher;
			GlobalEvent;
			IModule;
			ILoader;
			IVo;
			ITest;
			TickManager;
			GlobalParams;
			BaseSprite;
		}
	}
}