package ld29.core;

import flash.errors.Error;

/**
 * ...
 * @author namide.com
 */
class SoundManager
{
	
	private static var _CAN_INSTANTIATE:Bool = false;
	private static var _INSTANCE:SoundManager;
	
	public static inline var SAMPLE_TANG:String = 			"sound/tang.mp3";
	public static inline var SAMPLE_TING:String = 			"sound/ting.mp3";
	public static inline var SAMPLE_TITITING:String = 		"sound/tititing.mp3";
	public static inline var SAMPLE_TONG:String = 			"sound/tong.mp3";
	public static inline var SAMPLE_TUNG:String = 			"sound/tung.mp3";
	public static inline var SAMPLE_TUONG:String = 			"sound/tuong.mp3";
	
	public static inline var MUSIC:String = 				"sound/music.mp3";
	
	private var _allMutted:Bool = false;
	public function getAllMutted():Bool { return _allMutted; }
	public function mutteOnOff()
	{
		_allMutted = !_allMutted;
		
		setSoundsMutted( _allMutted );
		setMusicMutted( _allMutted );
	}
	
	private var _soundsMutted:Bool = false;
	public function getSoundsMutted():Bool { return _soundsMutted; }
	public function setSoundsMutted( val:Bool ):Void { _soundsMutted = val; }
	
	private var _musicMutted:Bool = false;
	public function getMusicMutted():Bool { return _musicMutted; }
	public function setMusicMutted( val:Bool ):Void
	{
		_musicMutted = val;
		if (_musicMutted)	_music.pause();
		else 				_music.play();
	}
	
	
	private var _music:SimpleSound;
	private var _sampleListNames:Array<String>;
	private var _sampleListSimpleSound:Array<SimpleSound>;
	
	
	public function new() 
	{
		if (_CAN_INSTANTIATE = false) throw new Error( "Singleton, use getInstance()" );
		
		_music = new SimpleSound( MUSIC, true );
		_music.setVolume( 0.12 );
		
		_sampleListNames = [SAMPLE_TANG, SAMPLE_TING, /*SAMPLE_TITITING,*/ SAMPLE_TONG, SAMPLE_TUNG, SAMPLE_TUONG];
		_sampleListSimpleSound = [];
		var i:Int;
		for ( i in 0..._sampleListNames.length )
		{
			_sampleListSimpleSound[i] = new SimpleSound( _sampleListNames[i] );
		}
	}
	
	public function playRandom():Void
	{
		var r:Int = Math.floor(_sampleListNames.length * Math.random());
		play( _sampleListNames[r] );
	}
	
	public function play( soundName:String ):Void
	{
		if ( !_soundsMutted ) 
		{
			var i:Int = Lambda.indexOf( _sampleListNames, soundName );
			_sampleListSimpleSound[i].play();
		}
	}
	
	public static function getInstance():SoundManager
	{
        if (_INSTANCE == null)
		{
            _CAN_INSTANTIATE = true;
            _INSTANCE = new SoundManager();
            _CAN_INSTANTIATE = false;
        }
        return _INSTANCE;
    }
	
	
}