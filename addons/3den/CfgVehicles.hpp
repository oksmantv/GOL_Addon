#define	ROCK	icon="\a3\ui_f\data\Map\LocationTypes\rockArea_CA.paa"
#define	TREE_LEAF	icon="\a3\ui_f\data\Map\LocationTypes\vegetationBroadleaf_CA.paa"
#define	TREE_FIR	icon="\a3\ui_f\data\Map\LocationTypes\vegetationFir_CA.paa"
#define	TREE_PALM	icon="\a3\ui_f\data\Map\LocationTypes\vegetationPalm_CA.paa"

#define	ALTIS_LOC(VAR1,VAR2)	model = ##\A3\plants_f\####VAR1####\####VAR2####.p3d
#define	MALDEN_LOC(VAR1,VAR2)	model = ##\A3\vegetation_f_argo\####VAR1####\####VAR2####.p3d
#define	TANOA_LOC(VAR1,VAR2)	model = ##\A3\vegetation_f_exp\####VAR1####\####VAR2####.p3d

#define	TAGBUSH(Var1)	TRIPLES(PREFIX,Bush,Var1)
#define	TAGclutter(Var1)	TRIPLES(PREFIX,clutter,Var1)
#define	TAGPlant(Var1)	TRIPLES(PREFIX,Plants,Var1)
#define	TAGTREE(Var1)	TRIPLES(PREFIX,Tree,Var1)

class CfgVehicles {
	class Static;
	class GW_BaseObject: Static {
		accuracy=1000;
		animated=0;
		armor=1000;
		author="GuzzenVonlidl";
		cost=0;
		displayName="";
		editorCategory="EdCat_Environment";
		editorSubcategory="";
		icon="iconObject";
//		model="";
		model="\A3\Weapons_F\empty.p3d";
		nameSound="";
		placement="vertical";
		scope=2;
		simulation="house";
	};

	// Bush
	class TAGBUSH(b_ArundoD2s_F): GW_BaseObject {
		author="GuzzenVonlidl";
		editorSubcategory="EdSubcat_GW_Bushes";
		displayName="ArundoD2s";
		ALTIS_LOC(Bush,b_ArundoD2s_F);
	};
	class TAGBUSH(b_ArundoD3s_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="ArundoD3s";
		ALTIS_LOC(Bush,b_ArundoD3s_F);
	};
	class TAGBUSH(b_FicusC1s_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="FicusC1s_F";
		ALTIS_LOC(Bush,b_FicusC1s_F);
	};
	class TAGBUSH(b_ficusC2d_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="ficusC2d_F";
		ALTIS_LOC(Bush,b_ficusC2d_F);
	};
	class TAGBUSH(b_FicusC2s_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="FicusC2s_F";
		ALTIS_LOC(Bush,b_FicusC2s_F);
	};
	class TAGBUSH(b_NeriumO2d_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="NeriumO2d_F";
		ALTIS_LOC(Bush,b_NeriumO2d_F);
	};
	class TAGBUSH(b_NeriumO2s_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="NeriumO2s_F";
		ALTIS_LOC(Bush,b_NeriumO2s_F);
	};
	class TAGBUSH(b_NeriumO2s_white_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="NeriumO2s_white_F";
		ALTIS_LOC(Bush,b_NeriumO2s_white_F);
	};
	class TAGBUSH(b_Thistle_Thorn_Green): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="Thistle_Thorn_Green";
		ALTIS_LOC(Bush,b_Thistle_Thorn_Green);
	};
	// Tanoa
	// Malden
	class TAGBUSH(b_OpuntiaFicusIndica3s_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="Malden OpuntiaFicusIndica3s_F";
		MALDEN_LOC(Bushes,b_OpuntiaFicusIndica3s_F);
	};
	class TAGBUSH(b_Vitis_vinifera_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		displayName="Malden Vitis_vinifera_F";
		MALDEN_LOC(Bushes,b_Vitis_vinifera_F);
	};

//	Cluster
	class TAGclutter(c_bigFallenBranches_pine): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		editorSubcategory="EdSubcat_GW_clutter";
		displayName="bigFallenBranches_pine";
		ALTIS_LOC(clutter,c_bigFallenBranches_pine);
	};
	class TAGclutter(c_bigFallenBranches_pine02): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="bigFallenBranches_pine02";
		ALTIS_LOC(clutter,c_bigFallenBranches_pine02);
	};
	class TAGclutter(c_bigFallenBranches_pine03): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="bigFallenBranches_pine03";
		ALTIS_LOC(clutter,c_bigFallenBranches_pine03);
	};
	class TAGclutter(c_BranchBig): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="BranchBig";
		ALTIS_LOC(clutter,c_BranchBig);
	};
	class TAGclutter(c_Carduus): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Carduus";
		ALTIS_LOC(clutter,c_Carduus);
	};
	class TAGclutter(c_Flower_Cakile): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Flower_Cakile";
		ALTIS_LOC(clutter,c_Flower_Cakile);
	};
	class TAGclutter(c_Flower_Low_Yellow2): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Flower_Low_Yellow2";
		ALTIS_LOC(clutter,c_Flower_Low_Yellow2);
	};
	class TAGclutter(c_Grass_BrushHigh_Green): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Grass_BrushHigh_Green";
		ALTIS_LOC(clutter,c_Grass_BrushHigh_Green);
	};
	class TAGclutter(c_Grass_Bunch_Small): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Grass_Bunch_Small";
		ALTIS_LOC(clutter,c_Grass_Bunch_Small);
	};
	class TAGclutter(c_Grass_Dry): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Grass_Dry";
		ALTIS_LOC(clutter,c_Grass_Dry);
	};
	class TAGclutter(c_Grass_Green): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Grass_Green";
		ALTIS_LOC(clutter,c_Grass_Green);
	};
	class TAGclutter(c_Grass_Tall_Dead): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Grass_Tall_Dead";
		ALTIS_LOC(clutter,c_Grass_Tall_Dead);
	};
	class TAGclutter(c_Grass_TuftDry): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Grass_TuftDry";
		ALTIS_LOC(clutter,c_Grass_TuftDry);
	};
	class TAGclutter(c_GrassCrooked): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassCrooked";
		ALTIS_LOC(clutter,c_GrassCrooked);
	};
	class TAGclutter(c_GrassDead_Tuft_Stony): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassDead_Tuft_Stony";
		ALTIS_LOC(clutter,c_GrassDead_Tuft_Stony);
	};
	class TAGclutter(c_GrassDesert_GroupHard): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassDesert_GroupHard";
		ALTIS_LOC(clutter,c_GrassDesert_GroupHard);
	};
	class TAGclutter(c_GrassGreen_GroupHard): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassGreen_GroupHard";
		ALTIS_LOC(clutter,c_GrassGreen_GroupHard);
	};
	class TAGclutter(c_GrassGreen_GroupSoft): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassGreen_GroupSoft";
		ALTIS_LOC(clutter,c_GrassGreen_GroupSoft);
	};
	class TAGclutter(c_GrassLong_DryBunch): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassLong_DryBunch";
		ALTIS_LOC(clutter,c_GrassLong_DryBunch);
	};
	class TAGclutter(c_GrassTall): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="GrassTall";
		ALTIS_LOC(clutter,c_GrassTall);
	};
	class TAGclutter(c_Rubble_Clutter1): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Rubble_Clutter1";
		ALTIS_LOC(clutter,c_Rubble_Clutter1);
	};
	class TAGclutter(c_Rubble_Clutter2): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Rubble_Clutter2";
		ALTIS_LOC(clutter,c_Rubble_Clutter2);
	};
	class TAGclutter(c_Rubble_Clutter3): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Rubble_Clutter3";
		ALTIS_LOC(clutter,c_Rubble_Clutter3);
	};
	class TAGclutter(c_Rubble_Clutter4): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Rubble_Clutter4";
		ALTIS_LOC(clutter,c_Rubble_Clutter4);
	};
	class TAGclutter(c_Rubble_Clutter5): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Rubble_Clutter5";
		ALTIS_LOC(clutter,c_Rubble_Clutter5);
	};
	class TAGclutter(c_Rubble_Clutter6): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Rubble_Clutter6";
		ALTIS_LOC(clutter,c_Rubble_Clutter6);
	};
	class TAGclutter(c_sharpStones_erosion): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="sharpStones_erosion";
		ALTIS_LOC(clutter,c_sharpStones_erosion);
	};
	class TAGclutter(c_sharpStones_erosion_v2): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="sharpStones_erosion_v2";
		ALTIS_LOC(clutter,c_sharpStones_erosion_v2);
	};
	class TAGclutter(c_StrGrassDry_group): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrGrassDry_group";
		ALTIS_LOC(clutter,c_StrGrassDry_group);
	};
	class TAGclutter(c_StrGrassDryMedium_group): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrGrassDryMedium_group";
		ALTIS_LOC(clutter,c_StrGrassDryMedium_group);
	};
	class TAGclutter(c_StrGrassGreen_group): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrGrassGreen_group";
		ALTIS_LOC(clutter,c_StrGrassGreen_group);
	};
	class TAGclutter(c_StrPlantGermader_group): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrPlantGermader_group";
		ALTIS_LOC(clutter,c_StrPlantGermader_group);
	};
	class TAGclutter(c_StrPlantGreenShrub): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrPlantGreenShrub";
		ALTIS_LOC(clutter,c_StrPlantGreenShrub);
	};
	class TAGclutter(c_StrThornGray): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrThornGray";
		ALTIS_LOC(clutter,c_StrThornGray);
	};
	class TAGclutter(c_StrThornGreen): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrThornGreen";
		ALTIS_LOC(clutter,c_StrThornGreen);
	};
	class TAGclutter(c_StrThornKhaki): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="StrThornKhaki";
		ALTIS_LOC(clutter,c_StrThornKhaki);
	};
	class TAGclutter(c_Thistle_Thorn_Brown): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Thistle_Thorn_Brown";
		ALTIS_LOC(clutter,c_Thistle_Thorn_Brown);
	};
	class TAGclutter(c_Thistle_Thorn_Desert): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Thistle_Thorn_Desert";
		ALTIS_LOC(clutter,c_Thistle_Thorn_Desert);
	};
	class TAGclutter(c_Thistle_Thorn_Gray): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Thistle_Thorn_Gray";
		ALTIS_LOC(clutter,c_Thistle_Thorn_Gray);
	};
	class TAGclutter(c_Thistle_Thorn_Green): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="Thistle_Thorn_Green";
		ALTIS_LOC(clutter,c_Thistle_Thorn_Green);
	};

// Tanoa
	class TAGclutter(c_forest_BiglLeaves): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="forest_BiglLeaves";
		TANOA_LOC(clutter\forest,c_forest_BiglLeaves);
	};
	class TAGclutter(c_forest_BiglLeaves2): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="forest_BiglLeaves2";
		TANOA_LOC(clutter\forest,c_forest_BiglLeaves2);
	};
	class TAGclutter(c_forest_fern): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="forest_fern";
		TANOA_LOC(clutter\forest,c_forest_fern);
	};
	class TAGclutter(c_forest_roots): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="forest_roots";
		TANOA_LOC(clutter\forest,c_forest_roots);
	};
	class TAGclutter(c_forest_violet_leaves): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="forest_violet_leaves";
		TANOA_LOC(clutter\forest,c_forest_violet_leaves);
	};
	class TAGclutter(c_forest_violet_leaves2): TAGclutter(c_bigFallenBranches_pine) {
		author="GuzzenVonlidl";
		displayName="forest_violet_leaves2";
		TANOA_LOC(clutter\forest,c_forest_violet_leaves2);
	};




//	Plant
	class TAGPlant(p_Reeds_F): TAGBUSH(b_ArundoD2s_F) {
		author="GuzzenVonlidl";
		editorSubcategory="EdSubcat_GW_Plants";
		displayName="Reeds_F";
		ALTIS_LOC(Plant,p_Reeds_F);
	};

//	Tanoa
	class TAGPlant(b_Rhizophora_F): TAGPlant(p_Reeds_F) {
		author="GuzzenVonlidl";
		displayName="Rhizophora_F";
		TANOA_LOC(Shrub,b_Rhizophora_F);
	};
	class TAGPlant(b_PiperMeth_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="PiperMeth_F";
		TANOA_LOC(Shrub,b_PiperMeth_F);
	};
	class TAGPlant(b_NeriumO2d_tanoa_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="NeriumO2d_tanoa_F";
		TANOA_LOC(Shrub,b_NeriumO2d_tanoa_F);
	};
	class TAGPlant(b_Leucaena_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Leucaena_F";
		TANOA_LOC(Shrub,b_Leucaena_F);
	};
	class TAGPlant(b_Gardenia_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Gardenia_F";
		TANOA_LOC(Shrub,b_Gardenia_F);
	};
	class TAGPlant(b_Gardenia_dec_02_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Gardenia_dec_02_F";
		TANOA_LOC(Shrub,b_Gardenia_dec_02_F);
	};
	class TAGPlant(b_Gardenia_dec_01_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Gardenia_dec_01_F";
		TANOA_LOC(Shrub,b_Gardenia_dec_01_F);
	};
	class TAGPlant(b_FicusC2d_tanoa_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="FicusC2d_tanoa_F";
		TANOA_LOC(Shrub,b_FicusC2d_tanoa_F);
	};
	class TAGPlant(b_Cycas_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Cycas_F";
		TANOA_LOC(Shrub,b_Cycas_F);
	};
	class TAGPlant(b_Colored_yellow_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Colored_yellow_F";
		TANOA_LOC(Shrub,b_Colored_yellow_F);
	};
	class TAGPlant(b_Colored_red_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Colored_red_F";
		TANOA_LOC(Shrub,b_Colored_red_F);
	};
	class TAGPlant(b_Cestrum_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Cestrum_F";
		TANOA_LOC(Shrub,b_Cestrum_F);
	};
	class TAGPlant(b_Calochlaena_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Calochlaena_F";
		TANOA_LOC(Shrub,b_Calochlaena_F);
	};

// Lianas
	class TAGPlant(d_LianaTangle_wide_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="LianaTangle_wide_F";
		TANOA_LOC(Lianas,d_LianaTangle_wide_F);
	};
	class TAGPlant(d_LianaTangle_narrow_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="LianaTangle_narrow_F";
		TANOA_LOC(Lianas,d_LianaTangle_narrow_F);
	};
// Crop
	class TAGPlant(t_Cacao_ripe_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Cacao_ripe_F";
		TANOA_LOC(Crop,t_Cacao_ripe_F);
	};
	class TAGPlant(t_Banana_wild_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Banana_wild_F";
		TANOA_LOC(Crop,t_Banana_wild_F);
	};
	class TAGPlant(t_Banana_slim_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Banana_slim_F";
		TANOA_LOC(Crop,t_Banana_slim_F);
	};
	class TAGPlant(t_Banana_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Banana_F";
		TANOA_LOC(Crop,t_Banana_F);
	};
	class TAGPlant(b_Sugarcane_sapling_single_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Sugarcane_sapling_single_F";
		TANOA_LOC(Crop,b_Sugarcane_sapling_single_F);
	};
	class TAGPlant(b_Sugarcane_sapling_row_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Sugarcane_sapling_row_F";
		TANOA_LOC(Crop,b_Sugarcane_sapling_row_F);
	};
	class TAGPlant(b_Sugarcane_mature_row_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Sugarcane_mature_row_F";
		TANOA_LOC(Crop,b_Sugarcane_mature_row_F);
	};
	class TAGPlant(b_Ginger_20_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Ginger_20_F";
		TANOA_LOC(Crop,b_Ginger_20_F);
	};
	class TAGPlant(b_Ginger_9_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Ginger_9_F";
		TANOA_LOC(Crop,b_Ginger_9_F);
	};
	class TAGPlant(b_Ginger_3_F): TAGPlant(b_Rhizophora_F) {
		author="GuzzenVonlidl";
		displayName="Ginger_3_F";
		TANOA_LOC(Crop,b_Ginger_3_F);
	};



//	Tree - Fir
	class TAGTREE(t_PinusP3s_F): GW_BaseObject {
		TREE_FIR;
		editorSubcategory="EdSubcat_GW_Trees";
		author="GuzzenVonlidl";
		displayName="FIR PinusP3s_F";
		ALTIS_LOC(Tree,t_PinusP3s_F);
	};
	class TAGTREE(t_PinusS1s_F): TAGTREE(t_PinusP3s_F) {
		author="GuzzenVonlidl";
		displayName="FIR PinusS1s_F";
		ALTIS_LOC(Tree,t_PinusS1s_F);
	};
	class TAGTREE(PinusS2s_b_F): TAGTREE(t_PinusP3s_F) {
		author="GuzzenVonlidl";
		displayName="FIR PinusS2s_b_F";
		ALTIS_LOC(Tree,t_PinusS2s_b_F);
	};
	class TAGTREE(PinusS2s_F): TAGTREE(t_PinusP3s_F) {
		author="GuzzenVonlidl";
		displayName="FIR PinusS2s_F";
		ALTIS_LOC(Tree,t_PinusS2s_F);
	};

//	Tree - Leaf
	class TAGTREE(t_BroussonetiaP1s_F): TAGTREE(t_PinusP3s_F) {
		TREE_LEAF;
		author="GuzzenVonlidl";
		displayName="Leaf BroussonetiaP1s_F";
		ALTIS_LOC(Tree,t_BroussonetiaP1s_F);
	};
	class TAGTREE(t_FicusB1s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf FicusB1s_F";
		ALTIS_LOC(Tree,t_FicusB1s_F);
	};
	class TAGTREE(t_FicusB2s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf FicusB2s_F";
		ALTIS_LOC(Tree,t_FicusB2s_F);
	};
	class TAGTREE(t_FraxinusAV2s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf FraxinusAV2s_F";
		ALTIS_LOC(Tree,t_FraxinusAV2s_F);
	};
	class TAGTREE(t_OleaE1s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Palm OleaE1s_F";
		ALTIS_LOC(Tree,t_OleaE1s_F);
	};
	class TAGTREE(t_OleaE2s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Palm OleaE2s_F";
		ALTIS_LOC(Tree,t_OleaE2s_F);
	};
	class TAGTREE(t_poplar2f_dead_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf poplar2f_dead_F";
		ALTIS_LOC(Tree,t_poplar2f_dead_F);
	};
	class TAGTREE(t_PopulusN3s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf PopulusN3s_F";
		ALTIS_LOC(Tree,t_PopulusN3s_F);
	};
	class TAGTREE(t_QuercusIR2s_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf QuercusIR2s_F";
		ALTIS_LOC(Tree,t_QuercusIR2s_F);
	};

//	Tree - Palm
	class TAGTREE(t_PhoenixC1s_F): TAGTREE(t_BroussonetiaP1s_F) {
		TREE_PALM;
		author="GuzzenVonlidl";
		displayName="Leaf PhoenixC1s_F";
		ALTIS_LOC(Tree,t_PhoenixC1s_F);
	};
	class TAGTREE(t_PhoenixC3s_F): TAGTREE(t_PhoenixC1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf PhoenixC3s_F";
		ALTIS_LOC(Tree,t_PhoenixC3s_F);
	};













// Tanoa
// Leaf
	class TAGTREE(t_Agathis_tall_F): TAGTREE(t_BroussonetiaP1s_F) {
		editorSubcategory="EdSubcat_GW_Trees_tanoa";
		author="GuzzenVonlidl";
		displayName="Leaf Agathis_tall_F";
		TANOA_LOC(Tree,t_Agathis_tall_F);
	};
	class TAGTREE(t_Agathis_wide_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Agathis_wide_F";
		TANOA_LOC(Tree,t_Agathis_wide_F);
	};
	class TAGTREE(t_Albizia_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Albizia_F";
		TANOA_LOC(Tree,t_Albizia_F);
	};
	class TAGTREE(t_Ficus_big_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Ficus_big_F";
		TANOA_LOC(Tree,t_Ficus_big_F);
	};
	class TAGTREE(t_Ficus_medium_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Ficus_medium_F";
		TANOA_LOC(Tree,t_Ficus_medium_F);
	};
	class TAGTREE(t_Ficus_small_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Ficus_small_F";
		TANOA_LOC(Tree,t_Ficus_small_F);
	};
	class TAGTREE(t_Inocarpus_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Inocarpus_F";
		TANOA_LOC(Tree,t_Inocarpus_F);
	};
	class TAGTREE(t_Leucaena_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Leucaena_F";
		TANOA_LOC(Tree,t_Leucaena_F);
	};
	class TAGTREE(t_Millettia_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Millettia_F";
		TANOA_LOC(Tree,t_Millettia_F);
	};
	class TAGTREE(t_Millettia_plantation_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Millettia_plantation_F";
		TANOA_LOC(Tree,t_Millettia_plantation_F);
	};
	class TAGTREE(t_Palaquium_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Palaquium_F";
		TANOA_LOC(Tree,t_Palaquium_F);
	};
	class TAGTREE(t_Rhizophora_F): TAGTREE(t_Agathis_tall_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Rhizophora_F";
		TANOA_LOC(Tree,t_Rhizophora_F);
	};

//	Tree - Palm
	class TAGTREE(t_Cocos_bend_F): TAGTREE(t_Agathis_tall_F) {
		TREE_PALM;
		author="GuzzenVonlidl";
		displayName="Palm Cocos_bend_F";
		TANOA_LOC(Tree,t_Cocos_bend_F);
	};
	class TAGTREE(t_Cocos_small_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm Cocos_small_F";
		TANOA_LOC(Tree,t_Cocos_small_F);
	};
	class TAGTREE(t_Cocos_tall_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm Cocos_tall_F";
		TANOA_LOC(Tree,t_Cocos_tall_F);
	};
	class TAGTREE(t_CocosNucifera2s_small_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm CocosNucifera2s_small_F";
		TANOA_LOC(Tree,t_CocosNucifera2s_small_F);
	};
	class TAGTREE(t_CocosNucifera3s_bend_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm CocosNucifera3s_bend_F";
		TANOA_LOC(Tree,t_CocosNucifera3s_bend_F);
	};
	class TAGTREE(t_CocosNucifera3s_tall_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm CocosNucifera3s_tall_F";
		TANOA_LOC(Tree,t_CocosNucifera3s_tall_F);
	};
	class TAGTREE(t_Cyathea_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm Cyathea_F";
		TANOA_LOC(Tree,t_Cyathea_F);
	};
	class TAGTREE(t_Pritchardia_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="Palm Pritchardia_F";
		TANOA_LOC(Tree,t_Pritchardia_F);
	};

//	Fallen
	class TAGTREE(d_TreeStump_natural_small_F): TAGTREE(t_Cocos_bend_F) {
		author="GuzzenVonlidl";
		displayName="TreeStump_natural_small_F";
		TANOA_LOC(TreeParts,d_TreeStump_natural_small_F);
	};
	class TAGTREE(d_TreeStump_natural_large_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="TreeStump_natural_large_F";
		TANOA_LOC(TreeParts,d_TreeStump_natural_large_F);
	};
	class TAGTREE(d_TreeStump_cut_small_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="TreeStump_cut_small_F";
		TANOA_LOC(TreeParts,d_TreeStump_cut_small_F);
	};
	class TAGTREE(d_TreeStump_cut_large_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="TreeStump_cut_large_F";
		TANOA_LOC(TreeParts,d_TreeStump_cut_large_F);
	};
	class TAGTREE(d_FallenTrunk_roots_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="FallenTrunk_roots_F";
		TANOA_LOC(TreeParts,d_FallenTrunk_roots_F);
	};
	class TAGTREE(d_FallenTrunk_clear_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="FallenTrunk_clear_F";
		TANOA_LOC(TreeParts,d_FallenTrunk_clear_F);
	};
	class TAGTREE(d_FallenTrunk_branches_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="FallenTrunk_branches_F";
		TANOA_LOC(TreeParts,d_FallenTrunk_branches_F);
	};
	class TAGTREE(d_FallenBranch_F): TAGTREE(d_TreeStump_natural_small_F) {
		author="GuzzenVonlidl";
		displayName="FallenBranch_F";
		TANOA_LOC(TreeParts,d_FallenBranch_F);
	};




// Malden
	class TAGTREE(t_Cupressus_stricta_2S_F): TAGTREE(t_PinusP3s_F) {
		author="GuzzenVonlidl";
		displayName="FIR Cupressus_stricta_2S_F";
		MALDEN_LOC(Trees,t_Cupressus_stricta_2S_F);
	};
	class TAGTREE(t_Cupressus_stricta_3S_F): TAGTREE(t_PinusP3s_F) {
		author="GuzzenVonlidl";
		displayName="FIR Cupressus_stricta_3S_F";
		MALDEN_LOC(Trees,t_Cupressus_stricta_3S_F);
	};

	class TAGTREE(t_Ficus_3D_F): TAGTREE(t_BroussonetiaP1s_F) {
		author="GuzzenVonlidl";
		displayName="Leaf Ficus_3D_F";
		MALDEN_LOC(Trees,t_Ficus_3D_F);
	};

	class TAGTREE(t_PhoenixRupicola1s_F): TAGTREE(t_OleaE1s_F) {
		author="GuzzenVonlidl";
		displayName="Palm PhoenixRupicola1s_F";
		MALDEN_LOC(Trees,t_PhoenixRupicola1s_F);
	};
	class TAGTREE(t_PhoenixRupicola3s_F): TAGTREE(t_OleaE1s_F) {
		author="GuzzenVonlidl";
		displayName="Palm PhoenixRupicola3s_F";
		MALDEN_LOC(Trees,t_PhoenixRupicola3s_F);
	};

	class GW_Road_Short: GW_BaseObject {
		author="GuzzenVonlidl";
		editorSubcategory="EdSubcat_GW_Road";
		displayName="Dirt Road Short";
		model="a3\roads_f\roads_new\path_W7_A0_105_R4000.p3d";
		class SimpleObject {
			animate[] = {};
			eden = 1;
			hide[] = {};
			init = "";
			verticalOffset = 0;
			verticalOffsetWorld = 0;
		};
	};
	class GW_Road_Long: GW_Road_Short {
		displayName="Dirt Road Long";
		model="a3\roads_f\roads_new\path_W7_A4_412_R200.p3d";
	};
	class GW_Road_Curve: GW_Road_Short {
		displayName="Dirt Road Curve";
		model="a3\roads_f\roads_new\path_W7_A33_423_R12.p3d";
	};
	class GW_Road_Curve_Long: GW_Road_Short {
		displayName="Dirt Road Curve Long";
		model="a3\roads_f\roads_new\path_W7_A32_815_R22.p3d";
	};
	class GW_Road_End: GW_Road_Short {
		displayName="Dirt Road End";
		model="a3\roads_f\roads_new\path_W7_L7_term.p3d";
	};
};
