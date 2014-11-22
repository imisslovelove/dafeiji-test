package com.endPage 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 结束界面
	 * @author Mack 358111542@qq.com
	 * 2013年8月30日 10:36:33
	 */
	public class EndPage extends Sprite 
	{
		/**
		 * 页面资源对象
		 */
		private var _endPage:Sprite;
		/**
		 * 分数文本框对象
		 */
		private var _scoreText:TextField;
		
		public function EndPage() 
		{
			//默认不可见
			this.visible = false;
			//创建资源对象
			_endPage = new EndPageResources();
			//添加到显示列表
			this.addChild(_endPage);
			//显示比例
			this._endPage.scaleX = this._endPage.scaleY = 0.5;
			//创建文本框
			this.creatScoreText();
		}
		
		/**
		 * 创建文本框
		 */
		private function creatScoreText():void
		{
			_scoreText = new TextField();
			_scoreText.text = "0000";
			_scoreText.setTextFormat(new TextFormat("宋体", 18));
			_scoreText.mouseEnabled = false;	
			//添加到显示列表
			this.addChild(_scoreText);
		}
		
		/**
		 * 设置分数
		 * @param	num 分数
		 */
		public function setScore(num:Number):void
		{
			//设置分数
			_scoreText.text = num.toString();
			//设置文本框字体
			_scoreText.setTextFormat(new TextFormat("宋体", 18));
			//设置文本框位置
			_scoreText.x = this.width / 2 - _scoreText.textWidth / 2;			
			_scoreText.y = this.height / 2 - _scoreText.textHeight / 2;			
		}
		
		/**
		 * 销毁
		 */
		public function destroy():void
		{
			this.visible = false;
			this.removeChild(_endPage);
			this.removeChild(_scoreText);
			_endPage = null;
			_scoreText = null;
		}
	}

}