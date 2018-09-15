package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	
	import cn.lin.core.interFace.IModule;
	import cn.lin.core.vo.module.ModuleUpdateVo;
	import cn.lin.core.vo.module.ModuleVo;
	
	public class Demo3 extends Sprite implements IModule
	{
		protected var _worker:Worker;
		protected var _mainToWorker:MessageChannel;
		protected var _workerToMain:MessageChannel;
		private var _moduleVo:ModuleVo;
		
		public function Demo3()
		{
			if(Worker.current.isPrimordial)
			{
				_worker = WorkerDomain.current.createWorker(Workers.cn_lin_demo3_worker_Demo3Worker);
				_mainToWorker = Worker.current.createMessageChannel(_worker);
				_workerToMain = _worker.createMessageChannel(Worker.current);
				
				_worker.setSharedProperty("mainToWorker", _mainToWorker);
				_worker.setSharedProperty("workerToMain", _workerToMain);
				
				_workerToMain.addEventListener(Event.CHANNEL_MESSAGE, onWorkerToMain);
				_worker.start();
			}
		}
		
		protected function onWorkerToMain(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		public function init():void
		{
			
		}
		
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
		
		public function dispose():void
		{
			
		}
		
	}
}