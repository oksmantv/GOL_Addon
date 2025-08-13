class CfgVehicles {
    class Plane_Fighter_01_Base_F;
    class B_Plane_Fighter_01_F: Plane_Fighter_01_Base_F {
        soundIncommingMissile[] = {"x\gw\addons\lockalerts\Data\sounds\F18_missile.wss", 2.8, 1};
        soundLocked[] = {"x\gw\addons\lockalerts\Data\sounds\F18_incoming.wss", 2.8, 1};
        
    };
    class B_Plane_Fighter_01_Stealth_F: Plane_Fighter_01_Base_F {
        soundIncommingMissile[] = {"x\gw\addons\lockalerts\Data\sounds\F18_missile.wss", 2.8, 1};
        soundLocked[] = {"x\gw\addons\lockalerts\Data\sounds\F18_incoming.wss", 2.8, 1};
    };

    class Plane;
    class USAF_A10: Plane {
        soundIncommingMissile[] = {"x\gw\addons\lockalerts\Data\sounds\A10_missile.wss", 2.5, 1};
        soundLocked[] = {"x\gw\addons\lockalerts\Data\sounds\A10_incoming.wss", 2, 1};
    };
    
};