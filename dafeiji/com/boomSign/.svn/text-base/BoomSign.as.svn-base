package com.boomSign 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 炸弹标记
	 * @author Mack 358111542@qq.com
	 * 2013年8月30日 08:55:26
	 */
	public class BoomSign extends Sprite 
	{
		/**
		 * 炸弹标记资源对象
		 */
		private var _boomSign:Sprite;
		/**
		 * 炸弹数量文本框对象
		 */
		private var _numberText:TextField;
		
		public function BoomSign() 
		{
			//创建资源对象
			_boomSign = new BoomSignResources();
			//添加到显示列表
			this.addChild(_boomSign);
			//显示比例
			this._boomSign.scaleX = this._boomSign.scaleY = 0.4;
		}
		
		/**
		 * 初始化炸弹标记对象
		 * @param	x X坐标
		 * @param	y Y坐标
		 */
		public function init(x:Number,y:Number):void
		{
			this.x = x;
			this.y = y;			
			//默认不显示
			this.visible = false;		
			//创建炸弹数量文本框对象
			this.creatNumberText();
		}
		
		/**
		 * 创建炸弹数量文本框对象
		 */
		private function creatNumberText():void
		{
			_numberText = new TextField();
			_numberText.text = "";
			_numberText.setTextFormat(new TextFormat("宋体", 18));
			//不接受鼠标事件
			_numberText.mouseEnabled = false;
			_numberText.x = _boomSign.width;
			_numberText.y = 8;
			//添加到显示列表
			this.addChild(_numberText);
		}
		
		/**
		 * 设置炸弹数量
		 * @param	num 炸弹数量
		 */
		public function setBoomNumber(num:Number):void
		{
			_numberText.text = num.toString();
			_numberText.setTextFormat(new TextFormat("宋体", 18));
		}
		
		/**
		 * 销毁
		 */
		public function destroy():void
		{
			this.visible = false;
			this.removeChild(_boomSign);
			this.removeChild(_numberText);
			_boomSign = null;
			_numberText = null;
		}
	}

}