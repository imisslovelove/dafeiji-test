package com.pausepage 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	/**
	 * 暂停页面
	 * @author Mack 358111542@qq.com
	 * 2013年8月27日 17:52:01
	 */
	public class PausePage extends Sprite 
	{
		/**
		 * 暂停页面资源对象
		 */
		private var _pausePage:Sprite;
		
		public function PausePage() 
		{
			//默认不显示
			this.visible = false;
			//创建资源对象
			_pausePage = new PausePageResources();
			//添加到显示列表
			this.addChild(_pausePage);
			//显示比例
			this._pausePage.scaleX = this._pausePage.scaleY = 0.5;
		}	
		
		/**
		 * 销毁
		 */
		public function destroy():void
		{
			this.visible = false;
			this.removeChild(_pausePage);
			_pausePage = null;
		}
	}

}