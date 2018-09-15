package cn.lin.core.gameLoader
{
	/**
	 * 为项目加载器配置默认属性
	 * level	：为加载等级	1 为普通等级，2为高级该加载程序为加载的内容进行分级别加载
	 * type		：为加载器类型	1 为SwfLoader类，用来加载模块的swf等二进制文件
	 * 							2 为FileLoader类，用来加载xml文件、图片等文件
	 * 							3 为SwfLoader类，用来加载外部的swf资源文件
	 * @author 林孟涛
	 * 
	 */
	public class LoaderConfig
	{
		/**
		 * 加载器个数
		 */
		public static const loaderNum:int = 5;
		
		public static const loader0:Object = {
			level	:	1,
			type	:	1
		};
		
		public static const loader1:Object = {
			level	:	1,
			type	:	3
		};
		
		public static const loader2:Object = {
			level	:	1,
			type	:	2
		};
		
		public static const loader3:Object = {
			level	:	2,
			type	:	1
		};
		
		public static const loader4:Object = {
			level	:	2,
			type	:	2
		}
	}
}