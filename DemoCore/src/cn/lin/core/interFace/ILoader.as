package cn.lin.core.interFace
{
	import cn.lin.core.gameLoader.vo.LoadVo;

	public interface ILoader
	{
		function set loadVo($loadVo:LoadVo):void;
		function get loadVo():LoadVo;
		function get level():int;
		function get type():int;
		function get isLoading():Boolean;
		function get url():String;
		function get loadLv():int;
		function get loadType():int;
		function set loadLv($loadLv:int):void;
		function set loadType($loadType:int):void;
		function canLoad(type:int):Boolean;
	}
}