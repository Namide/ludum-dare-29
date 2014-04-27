package ld29.renderEngine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.PixelSnapping;
import flash.display.Shape;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.renderEngine.RenderEngine.BGBD;
import ld29.settings.StageSettings;

@:bitmap("ld29/assets/bg.png")
class BGBD extends flash.display.BitmapData
{
    
}

/**
 * ...
 * @author namide.com
 */
class RenderEngine extends Bitmap
{
	
	private var _bg:BitmapData;
	private var _renderBD:BitmapData;
	
	private var _lava:Shape;
	
	public function new() 
	{
		_bg = new BGBD( StageSettings.W, StageSettings.H, false );
		_renderBD = new BitmapData( StageSettings.W, StageSettings.H, false, 0x000000 );
		super( _renderBD, PixelSnapping.ALWAYS, false );
		
		
		
		var m:Matrix = new Matrix();
		m.createGradientBox( StageSettings.W - x, StageSettings.H - y, Math.PI / 2, 0, 0 );
		_lava = new Shape();
		_lava.graphics.beginGradientFill( 	GradientType.LINEAR,
											[0xf48a00, 0xf45000, 0xf44500],
											[0, 1, 1],
											[0, 10, 255],
											m, SpreadMethod.PAD);
		
		_lava.graphics.drawRect( 0, 0, StageSettings.W, StageSettings.H * 0.5 );
		_lava.graphics.endFill();
	}
	
	public function refresh( entities:Iterable<Entity>, ground:Ground )
	{
		var m:Matrix = new Matrix();
		var p:Point = new Point();
		_renderBD.copyPixels( _bg, _bg.rect, p );
		
		var groundDrawed:Bool = false;
		
		for ( entity in entities )
		{
			if ( !groundDrawed && entity.type != Entity.TYPE_GRAPHIC_UNDER )
			{
				groundDrawed = drawGround(ground, m);
				
				p.setTo( 0, 0 );
				_renderBD.applyFilter( _renderBD, _renderBD.rect, p, new BlurFilter(8, 8, 1 ) );
				
			}
			
			p.setTo( entity.x, entity.y );
			var bd:BitmapData = entity.graphic.bd;
			_renderBD.copyPixels( bd, bd.rect, p, bd.transparent );
		}
		drawLava(m);
		
		bitmapData = _renderBD;
	}
	
	private function drawGround(ground:Ground, m:Matrix)
	{
		m.createBox( 1, 1, 0, ground.x, ground.y );
		_renderBD.draw( ground.shape, m );
		return true;
	}
	
	private function drawLava(m:Matrix)
	{
		var h:Int = Math.ceil( (Math.sin( Lib.getTimer() * 0.001 ) + 1) * 0.5 * 20 + 10 );
		/*var rect:Rectangle = new Rectangle( 0, StageSettings.H - h, StageSettings.W, h );
		_renderBD.fillRect( rect, 0xf45000 );*/
		m.createBox( 1, 1, 0, 0, StageSettings.H - h );
		_renderBD.draw( _lava, m );
	}
}