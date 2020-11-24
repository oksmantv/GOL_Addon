
class CfgVehicles {
	class Car_F;
	class Boat_F;
	class Rubber_duck_base_F: Boat_F {
		enginePower = 130;
		maxSpeed = 60;
		overSpeedBrakeCoef = 1.0;
		redRPM = 2000;
		rudderForceCoef = 0.08;
		rudderForceCoefAtMaxSpeed = 0.0001;
		thrustDelay = 1.5;
		turnCoef = 2.0;

		class complexGearbox {
			GearboxRatios[] = {"R1", -2, "N", 0, "D1", 1, "D2", 2};
			TransmissionRatios[] = {"High", 1};
			gearBoxMode = "auto";
			moveOffGear = 1;
			driveString = "D";
			neutralString = "N";
			reverseString = "R";
	 	};
	};

	class All;
	class AllVehicles: All {
		class NewTurret {
			startEngine = 0; //1;
		};
	};
	class Quadbike_01_base_F: Car_F {
		turnCoef = 2.5;
	};

	class ContainerSupply;
	class Supply1: ContainerSupply {
		MAXLOAD140
	};
	class Supply2: ContainerSupply {
		MAXLOAD140
	};
	class Supply3: ContainerSupply {
		MAXLOAD140
	};
	class Supply4: ContainerSupply {
		MAXLOAD140
	};
	class Supply5: ContainerSupply {
		MAXLOAD140
	};
	class Supply6: ContainerSupply {
		MAXLOAD140
	};
	class Supply7: ContainerSupply {
		MAXLOAD140
	};
	class Supply8: ContainerSupply {
		MAXLOAD140
	};
	class Supply9: ContainerSupply {
		MAXLOAD140
	};
	class Supply10: ContainerSupply {
		MAXLOAD140
	};
	class Supply20: ContainerSupply {
		MAXLOAD140
	};
	class Supply30: ContainerSupply {
		MAXLOAD140
	};
	class Supply40: ContainerSupply {
		MAXLOAD140
	};
	class Supply50: ContainerSupply {
		MAXLOAD140
	};
	class Supply60: ContainerSupply {
		MAXLOAD140
	};
	class Supply70: ContainerSupply {
		MAXLOAD140
	};
	class Supply80: ContainerSupply {
		MAXLOAD140
	};
	class Supply90: ContainerSupply {
		MAXLOAD140
	};
	class Supply100: ContainerSupply {
		MAXLOAD140
	};
	class Supply110: ContainerSupply {
		MAXLOAD140
	};
	class Supply120: ContainerSupply {
		MAXLOAD140
	};
	class Supply130: ContainerSupply {
		MAXLOAD140
	};
};
