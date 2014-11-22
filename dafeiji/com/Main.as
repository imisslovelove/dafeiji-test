package com
{
	import flash.display.Sprite;
	import flash.events.Event;	
	import com.manager.GameManager;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.text.TextField;
	
	/**
	 * 文档类
	 * @author Mack 358111542@qq.com
	 * 2013年8月26日 9:05:15
	 */
	public class Main extends Sprite 
	{
		private var gameM:GameManager;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (stage) 
				init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			txtinfo.mouseEnabled = false;
			gameM = new GameManager(stage.stageWidth,stage.stageHeight,stage);
			this.addChild(gameM);
			this.addChild(txtinfo);
		}		
	}
	
}