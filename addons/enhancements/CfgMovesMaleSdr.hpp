
class CfgMovesBasic;
class CfgMovesMaleSdr: CfgMovesBasic {
	class States {
		class amovpercmstpslowwrfldnon;		// Rifle
		class amovpercmstpsraswrfldnon: amovpercmstpslowwrfldnon {	// Idle
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};

		class amovpercmwlksraswrfldf: amovpercmstpsraswrfldnon {	// Walking Forward
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmwlksraswrfldl: amovpercmwlksraswrfldf {	// Walking Left
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmwlksraswrfldr: amovpercmwlksraswrfldf {	// Walking Right
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};

		class amovpercmtacsraswrfldf: amovpercmwlksraswrfldf {	// Tactial Forward
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmtacsraswrfldl: amovpercmtacsraswrfldf {	// Tactial Left
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmtacsraswrfldr: amovpercmtacsraswrfldf {	// Tactial Right
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};

		class amovpercmrunsraswrfldfl;
		class amovpercmrunsraswrfldf: amovpercmstpsraswrfldnon {	// Jogging Forward
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmrunsraswrfldl: amovpercmrunsraswrfldfl {		// Jogging Left
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmrunsraswrfldr: amovpercmrunsraswrfldfl {		// Jogging Right
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};

		class amovpercmrunslowwrfldfl;	// Lowered
		class amovpercmrunslowwrfldf: amovpercmstpslowwrfldnon {	// Jogging Forward
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmrunslowwrfldl: amovpercmrunslowwrfldfl {	// Jogging Left
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};
		class amovpercmrunslowwrfldr: amovpercmrunslowwrfldfl {	// Jogging Right
			collisionShape = "A3\anims_f\data\geom\sdr\Perc_Wrfl_Low.p3d";
		};


		// Rifle - Back
		class amovpercmstpsnonwnondnon;
		class amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon: amovpercmstpsnonwnondnon {
			speed = 0.8;
		};
		// Swim
		class AswmPercMstpSnonWnonDnon;
		class AsswPercMstpSnonWnonDnon;
		class AbswPercMstpSnonWnonDnon;
		class AdvePercMstpSnonWrflDnon;
		class AsdvPercMstpSnonWrflDnon;
		class AbdvPercMstpSnonWrflDnon;
		class AswmPercMrunSnonWnonDf: AswmPercMstpSnonWnonDnon {
			speed = 0.5;
		};
		class AsswPercMrunSnonWnonDf: AsswPercMstpSnonWnonDnon {
			speed = 0.5;
		};
		class AbswPercMrunSnonWnonDf: AbswPercMstpSnonWnonDnon {
			speed = 0.4;
		};
		class AdvePercMrunSnonWrflDf: AdvePercMstpSnonWrflDnon {
			speed = 0.2;
		};
		class AsdvPercMrunSnonWrflDf: AsdvPercMstpSnonWrflDnon {
			speed = 0.2;
		};
		class AbdvPercMrunSnonWrflDf: AbdvPercMstpSnonWrflDnon {
			speed = 0.2;
		};
/*
		class LadderCivilStatic;
		class LadderCivilUpLoop: LadderCivilStatic {
			speed = "1.05/(2/3)";
		};
*/
	};
};
