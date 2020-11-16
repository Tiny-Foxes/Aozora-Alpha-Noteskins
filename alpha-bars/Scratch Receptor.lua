return Def.ActorFrame {

	-- BG
	
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(60,SCREEN_HEIGHT+1000)
		end;
		OnCommand=function(self)
			self:diffuse(color("#000000")):diffusealpha(.0)
		end;
		PressCommand=function(self)
			self:diffuse(color("#ffffff")):diffusealpha(.125):decelerate(0.1)
		end;
		LiftCommand=function(self)
			self:diffuse(color("#000000")):diffusealpha(.0):decelerate(0.1)
		end;
		
	};	
	
	--left
	
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(1,SCREEN_HEIGHT+1000):x(32)
		end;
		OnCommand=function(self)
			self:diffuse(color("#FFFFFF")):diffusealpha(0.125)
		end;

	};	
	
	--right
	
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(1,SCREEN_HEIGHT+1000):x(-32)
		end;
		OnCommand=function(self)
			self:diffuse(color("#FFFFFF")):diffusealpha(0.125)
		end;
	};	
	
	-- RECEPTOR
	
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(64,16)
		end;
		OnCommand=NOTESKIN:GetMetricA('ReceptorBar', 'InitCommand');
	};	
	
	
}