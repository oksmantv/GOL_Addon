
class CfgLights {
	class SmallFireLight {
		intensity = "2750*(power interpolate[0.1, 1.0, 0.4, 1.0])";
		position[] = {0,0.6,0};
		class Attenuation {
			start = 5;
			constant = 7;
			quadratic = 12;
			hardLimitStart = 9;
			hardLimitEnd = 35;
		};
	};
	class SmallFirePlaceLight {
		intensity = "1800*(power interpolate[0.1, 1.0, 0.4, 1.0])";
		position[] = {0,0.5,0};
		class Attenuation {
			start = 5;
			constant = 7;
			quadratic = 12;
			hardLimitStart = 9;
			hardLimitEnd = 35;
		};
	};
};
