package com.bg 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 背景类
	 * @author Mack 358111542@qq.com
	 * 2013年8月27日 17:58:39
	 */
	public class BGControl extends Sprite 
	{
		/**
		 * 背景资源对象
		 */
		private var _bgMC:MovieClip;
		/**
		 * 循环背景
		 */
		private var _loopMC:Sprite;
		/**
		 * 下落的速度
		 */
		private var _speedY:uint = 5;
		/**
		 * 循环背景高度
		 */
		private var _loopHight:int = 560;
		
		public function BGControl() 
		{
			//创建资源对象
			this._bgMC = new BGResources();
			//添加到显示列表
			this.addChild(this._bgMC);
			//赋值
			this._loopMC = this._bgMC.loopMC;
			//复位
			this.reset();
		}
		
		/**
		 * 复位
		 */
		public function reset():void
		{
			this._loopMC.y = -_loopHight;
		}
		
		/**
		 * 运行函数
		 */
		public function run():void
		{
			//循环背景
			this._loopMC.y += this._speedY;
			if (this._loopMC.y > 0)
			{
				this._loopMC.y -= _loopHight;
			}
		}
		
		/**
		 * 销毁
		 */
		public function destroy():void
		{
			this.visible = false;
			this.removeChild(_bgMC);
			_bgMC = null;
			_loopMC = null;
		}
		
		public function get speedY():uint 
		{
			return _speedY;
		}
		
		public function set speedY(value:uint):void 
		{
			_speedY = value;
		}
	}
}